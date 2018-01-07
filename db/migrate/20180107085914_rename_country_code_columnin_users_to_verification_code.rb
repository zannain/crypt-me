class RenameCountryCodeColumninUsersToVerificationCode < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :country_code, :verification_code
  end
end
