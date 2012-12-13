class CreateAbonents < ActiveRecord::Migration
  def up
    execute " CREATE OR REPLACE VIEW V_ABONENTS AS SELECT         v.account, v.ABONENT_NAME,  v.KOROBKA , sum(v.PAGE_COUNT) as PAGE_COUNT, min(v.CREATED_AT) as CREATED_AT, max(v.CREATED_AT) as UPDATE_AT FROM V_DOCUMENTS v group by v.account, v.ABONENT_NAME, v.KOROBKA  "
  end
  
  def down
  end
end
