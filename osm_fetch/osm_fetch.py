import json

import osm2geojson
import requests
from geopy.geocoders import Nominatim

OVERPASS_URL = "http://overpass-api.de/api/interpreter"

def get_area_id(city_name: str):
    # Geocoding request via Nominatim
    geolocator = Nominatim(user_agent="city_compare")
    geo_results = geolocator.geocode(city_name, exactly_one=False, limit=3)

    # Searching for relation in result set
    for r in geo_results:
        # print(r.address, r.raw.get("osm_type"))
        if r.raw.get("osm_type") == "relation":
            city = r
            break

    # Calculating area id
    area_id = int(city.raw.get("osm_id")) + 3600000000
    return area_id


def read_json(filepath):
    with open(filepath, "r") as f:
        return json.load(f)


def exec_query(area_id: int, query: str):
    request = f"[out:json];area({area_id})->.searchArea;({query});out geom;"
    print(request)
    response = requests.get(OVERPASS_URL, params={"data": request})
    response.raise_for_status()
    data = response.json()
    return osm2geojson.json2geojson(data)

def exec_base_query(area_id: int):
    request = f"[out:json];area({area_id})->.searchArea;rel(pivot.searchArea);out geom;"
    print(request)
    response = requests.get(OVERPASS_URL, params={"data": request})
    response.raise_for_status()
    data = response.json()
    return osm2geojson.json2geojson(data)


def gen_query(query_list: list[str], query_key: str = "nwr"):
    return "".join(
        [f"{query_key}[{query_item}](area.searchArea);" for query_item in query_list]
    )


def osm_query(items: list[str], area):
    area_id = get_area_id(area)
    return exec_query(area_id, gen_query(items))

def osm_base_query(area):
    area_id = get_area_id(area)
    return exec_base_query(area_id)


def write_output_geojson(geo_json, filename):
    with open(filename, "w") as of:
        json.dump(geo_json, of)

def get_base(area):
    area_id = get_area_id(area)
    return exec_base_query(area_id)