require 'sequel_postgresql_triggers'
Sequel.migration do
  change do
    create_table(:channel_logs) do
      primary_key :id
      String :nick
      DateTime :at
      String :message
      foreign_key :user_id
      foreign_key :channel_id
    end
    pgt_created_at :channel_logs, :at
  end
end
