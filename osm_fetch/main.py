
from osm_fetch import write_output_geojson, osm_query, osm_base_query
from yaml_parser import UnsealingConfig, parse_config

def fetch_base(config: UnsealingConfig):
    write_output_geojson(osm_base_query(config.city), "base.geojson")

def fetch_layers(config: UnsealingConfig):
    for layer in config.layers:
        print(layer.name)
        print(layer.operation)
        write_output_geojson(osm_query([layer.name], config.city), f"{layer.name}.geojson")

if __name__ == "__main__":
    config = parse_config("../test.yaml")
    fetch_base(config)
    fetch_layers(config)