class MdxController < ApplicationController
  def index
    @title = "Enter MDX query"
    if params[:q]
      @result = Dwh.olap.execute(params[:q])
      #@result is of type Mondrian::OLAP::Result.
      #@raw_cell_set in Result class is of type
      #org.olap4j.CellSet.
      format_result
    end
  end

  def builder
    @title = "Enter query builder expression"
    if params[:q]
      @query = Dwh.instance_eval(params[:q])
      @mdx = @query.to_mdx
      @result = @query.execute
      format_result
    end
    render :action => 'index'
  end

  private

  def format_result
    @table_html = @result.to_html(:formatted => true)
  end

end
