module Pageflow
  FactoryGirl.define do
    factory :folder, :class => Folder do
      name "some folder"
      account
    end
  end
end
