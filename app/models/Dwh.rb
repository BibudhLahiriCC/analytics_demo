require 'mondrian-olap'

class Dwh
  @schema = Mondrian::OLAP::Schema.define do
    cube 'EnterPlacements' do
      table 'physical_location_records'
      dimension 'LocationType' do
        #creating a degenerate dimension
        hierarchy :has_all => true do
          level :name => 'LocType', :column => 'physical_location_type',
                :unique_members => true
        end #end hierarchy
      end #end dimension
      dimension 'StartTimes', :foreign_key => 'physical_location_id',
                :type => 'TimeDimension' do
        hierarchy :has_all => true, :all_member_name => 'All StartTimes',
                  :primary_key => 'id' do
          table 'physical_location_placements'
          level :name => 'Year', :unique_members => true,
                :type => 'Numeric', :level_type => 'TimeYears' do
            key_expression do
              # #KeyExpression is a class derived from SchemaElement.
              # #elements is a method in SchemaElement, which takes an array
              # #of strings and concatenates them and returns. From class Level,
              # #the method elements is called with inputs :key_expression,
              # #:name_expression etc. KeyExpression simply calls the
              # #elements method with symbol :sql. Sql is also a class derived
              # #from SchemaElement. The following line creates an object
              # #of class Sql.
              sql "EXTRACT(YEAR FROM start_date)"
            end #end key_expression
            name_expression do
              sql "to_char(start_date, 'YYYY')", :dialect => 'postgresql'
            end
          end #end level
          level :name => 'Month', :unique_members => false,
                :type => 'Numeric', :level_type => 'TimeMonths' do
            key_expression do
              sql "EXTRACT(MONTH FROM start_date)"
            end #end key_expression
            name_expression do
              sql "to_char(start_date, 'MM')", :dialect => 'postgresql'
            end
          end #end level
        end #end hierarchy
      end #end dimension
      measure 'People', :column => 'person_id', :datatype => "Integer", :aggregator => 'count'
      end #end cube

      cube 'DaysSinceLastVisit' do
      table 'days_since_last_visit'
      dimension 'HistogramBucket' do
        hierarchy :has_all => true do
          level :name => 'HistBucket', :type => 'Numeric' do
            key_expression do
              sql "n_days_since_last_visit/7"
            end #end key_expression
            name_expression do
              sql "to_char(7*(n_days_since_last_visit/7), '999') || '-' || to_char(7*(n_days_since_last_visit/7) + 6, '999')",
                  :dialect => 'postgresql'
            end
          end #end level
        end #end hierarchy
      end #end dimension
      dimension 'Gender' do
        #creating a degenerate dimension
        hierarchy :has_all => true do
          level :name => 'Gender', :column => 'gender',
                :unique_members => true
        end #end hierarchy
      end #end dimension
      measure 'Children', :column => 'person_id',
              :datatype => "Integer", :aggregator => 'count'
      end #end cube


  end #end schema

  def self.schema; @schema; end

  params = ActiveRecord::Base.configurations[Rails.env].symbolize_keys
  @olap = Mondrian::OLAP::Connection.create(
    :driver => params[:adapter] == 'oracle_enhanced' ? 'oracle' : params[:adapter],
    :host => params[:host],
    :database => params[:database],
    :username => params[:username],
    :password => params[:password],
    :schema => @schema
  )

  def self.olap; @olap; end

end
