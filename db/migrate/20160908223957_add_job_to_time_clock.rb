class AddJobToTimeClock < ActiveRecord::Migration
  def change
    add_reference :time_clocks, :job, index: true
  end
end
