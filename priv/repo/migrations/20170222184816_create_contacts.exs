defmodule NewsFeed.Repo.Migrations.CreateContacts do
  use Ecto.Migration

  def change do
  	create table(:contacts, primary_key: false) do
      add :id,            	:uuid,    primary_key: true    
      add :email,     	    :string
      add :name,     		    :string
      add :title,           :string
      add :have_replied,    :string
      add :message,     	  :string
      add :inserted_at,   	:string
      add :updated_at,    	:string
    end
  end
end
