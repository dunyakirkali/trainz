class TrainsController < ApplicationController
  def index
    ba_query = "<query type='relation'><has-kv k='route' v='train'/><has-kv k='name' modv='not' regv=''/><has-kv k='network' modv='not' regv=''/></query>"
    options= {
      bbox: {
        s: params[:s],
        n: params[:n],
        w: params[:w],
        e: params[:e]
      },
      timeout: 900,
      element_limit: 1073741824,
      json: true
    }
    overpass = OverpassAPI.new(options)
    result_hash = overpass.query(ba_query)
    render json: result_hash
  end
end
