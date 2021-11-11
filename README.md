# meta_chef

This cookbook is a proof of concept purly attribute driven Cookbook.

## Theory

Chef is a declarative DSL that extends the functionality of Ruby.  Since ultimately it's just Ruby, we can (ab)use the meta programming features to manipulate resources during the run.  Since we're able to declare resources on the fly, this gives us the ability to declare resources entirely in attribute files.  We can pass either a hash of property names and values or an array of property hashes.


Resources can be dynamically created by calling the `create_resource` helper function and passing the name of the resource and either a hash of properties or an array of hashes of properties.

```ruby
create_resource :file, {
  path: '/tmp/some_file',
  content: 'this is text in a file',
  action: :create,
}
```

Would create the file resource:

```ruby
file 'dynamic file resource name' do
  path '/tmp/some_file'
  content 'this is text in a file',
  action :create
end
```

Of course this is a convoluted way to create a resource, but if we were to do this from an attribute, we could create multiple resources simply by declaring them as attributes:

```ruby
default['my_resources'] = {
  file: {
    path: '/tmp/some_file',
    content: 'this is text ina file',
    action: :create,
  },
  template: {
    path: '/tmp/foo',
    source: 'foo.erb',
  }
}
```

The resource name is defined as the key of the hash, and a hash of properties is the "value".

Of course, key names must be unique in Chef, so we can pass an array of hashes if we need to create more than one of any resource.

## Usage

Create a hash at `default['meta_chef']['group_name']` of resource hashes (as described above), and include `meta_chef::default`.

Alternatively use `create_resource` directly.

See `test/fixtures/meta_chef_test/attributes/default.rb` for example usage.

## Test Kitchen

Test kitchen leverages Kitchen-Dokken.  On any system with Chef Workstation and Docker installed, `kitchen verify` or `kitchen test` will execute the test fixture cookbook in `test/fixtures/meta_chef_test`