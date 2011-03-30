class Faq < ActiveRecord::Base

  validates_presence_of :question, :answer, :permalink

end
