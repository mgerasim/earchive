class UpdateTypeFiledInUsers < ActiveRecord::Migration
  def up
    execute " update users set type='User' where is_not_ad='N' "
    execute " update users set type='Worker' where is_not_ad='Y' "
  end

  def down
  end
end
