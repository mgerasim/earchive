class RenameLdapAccountToNicknameInUsers < ActiveRecord::Migration
  def change
    rename_column :users, :ldap_account, :nickname
  end
end
