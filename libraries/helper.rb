#
# Chef Infra Documentation
# https://docs.chef.io/libraries/
#

module MetaChef
  module Helpers
    def create_resource(resource_name, properties_list)
      # is there a more elegant way to do this?
      #
      properties_list = [properties_list] if properties_list.is_a?(Hash)

      properties_list.each do |properties|
        new_resource = declare_resource resource_name, "dynamic resource #{resource_name}"

        properties.except(*new_resource.instance_variables).each do |property, value|
          new_resource.send property, value
        end
      end
    end
  end
end

Chef::DSL::Recipe.include MetaChef::Helpers
