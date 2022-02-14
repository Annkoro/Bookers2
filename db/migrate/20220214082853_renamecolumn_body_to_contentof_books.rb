class RenamecolumnBodyToContentofBooks < ActiveRecord::Migration[6.1]
  def change
    # rename_column :テーブル名, :変更前のカラム名, :変更後のカラム名
    # remove_columns :テーブル名, :カラム名, :カラム名,  :カラム名
    remove_columns :books, :body
  end
end
