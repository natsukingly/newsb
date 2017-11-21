class AddColumnFakeNewsReportToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :fake_news_report, :boolean, default: false
  end
end
