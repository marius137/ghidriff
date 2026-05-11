from pathlib import Path


def pytest_collection_modifyitems(config, items):
    for item in items:
        relpath = Path(item.path).relative_to(config.rootpath)
        if relpath.parts[:1] == ("tests",) and item.get_closest_marker("fast") is None:
            item.add_marker("integration")
