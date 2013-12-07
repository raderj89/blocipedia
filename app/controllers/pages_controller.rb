class PagesController < ApplicationController
  before_filter :setup, only: [:home]

  def home
    @free_plan
    @premium_plan
  end

  def about
  end

  private

  def setup
    plans = Plan.all
    plans.each do |plan|
      if plan.id == 1
        @free_plan = plan
      else
        @premium_plan = plan
      end
    end
  end
end
