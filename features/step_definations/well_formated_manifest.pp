node 'cookbook' {

file {'/tmp/hello':
        content => "Hello, dude \n",
  }

  include puppet
}

node 'cookbook-test' {
  include puppet
}
