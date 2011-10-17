class RenameToColonial < ActiveRecord::Migration
  def self.up
    p = Product.find_by_permalink('american-harvester-cider-mill-apple-press')
    p.permalink = 'colonial-cider-mill-apple-press'
    p.save!
  end

  def self.down
    p = Product.find_by_permalink('colonial-cider-mill-apple-press')
    p.permalink = 'american-harvester-cider-mill-apple-press'
    p.save!
  end
end
