class PagesController < ApplicationController
  def top32
    @contestants = Contestant.all.map{|c| [c.name, Match.where(winner: c).count]}.sort_by { |a| a[1] }.reverse
  end

  def home;end
end
