from json import loads
from pytest import mark


def get_result(json_response):
    return loads(json_response.data).get('result')


def test_get_all_words(client):
    response = client.get('/words')
    assert len(get_result(response)) == 10


@mark.parametrize(
    ('prefix', 'suffix', 'predicate'),
    (
            ('b', '', lambda w: w.startswith('b')),
            ('', 'a', lambda w: w.endswith('a')),
            ('b', 'a', lambda w: w.startswith('b') and w.endswith('a')),
    )
)
def test_get_words_starting_with_b(client, prefix, suffix, predicate):
    response = client.get('/words?prefix={}&suffix={}'.format(prefix, suffix))
    result = get_result(response)
    assert all(predicate(w) for w in get_result(response)) and result


def test_get_words_with_invalid_prefix(client):
    response = client.get('/words?prefix=asdgmklqwer')
    assert len(get_result(response)) == 0


@mark.parametrize(
    ('page', 'expected'),
    (
            (1, ['aardvark', 'aardvarks']),
            (2, [])
    )
)
def test_get_pages(client, page, expected):
    response = client.get('/words?prefix=aardvark&page=' + str(page))
    assert get_result(response) == expected
