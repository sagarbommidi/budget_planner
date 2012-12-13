BudgetPlanner::Application.routes.draw do

  devise_for :users do 
    root :to => 'devise/sessions#new'
  end

  resources :users, :only => [] do

    resources :incomes do
    end

    resources :expenses do
    end

    resources :tags do
    end

    resources :budgets do
    end

    resource :profile, :except => [:new, :create] do

    end
  end

  
end
