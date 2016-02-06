# encoding: UTF-8
class TrainsController < ApplicationController
  def draw
    grouped_nodes = {}

    # Get Ways
    ba_query = '<query type="way"><has-kv k="railway" regv="rail"/></query><union><item/><recurse type="down"/></union>'
    result = overpass.query(ba_query).to_a

    ways = result.select { |item| item[:type] == 'way' }
    puts "#{ways.count} ways"

    nodes = result.select { |item| item[:type] == 'node' }
    puts "#{nodes.count} nodes"

    # Get Nodes

    # ways.each_with_index do |way, index|
    #   ways_nodes = way[:nodes].map { |way_node_id| nodes.find { |node| node[:id] == way_node_id } }
    #   # ways_nodes = way[:nodes].map { |way_node_id| nodes[way_node_id] }
    #   grouped_nodes[way[:id].to_s] = ways_nodes
    # end

    render json: grouped_nodes
  end

  def trains
    ba_query = '<query type="relation"><has-kv k="type" regv="route"/><has-kv k="route" regv="train"/></query>'
    result = overpass.query(ba_query).to_a
    puts result.count
    trains = result.select { |item| item[:type] == 'relation' }
    puts trains.count
    render json: trains
  end

  def countries
    render json: ISO3166::Country.all_translated
  end

  private

  def options
    {
      bbox: {
        s: params[:s],
        n: params[:n],
        w: params[:w],
        e: params[:e]
      },
      timeout: 30,
      # element_limit: 107374,
      json: true
    }
  end

  def overpass
    @overpass ||= OverpassAPI.new(options)
  end
end
