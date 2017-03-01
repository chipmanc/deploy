update_file:
  cmd.cmd.run:
    - tgt: test.chrischipman.com
    - arg:
      - echo {{ data['id'] }} >> /tmp/id
      - echo blah >> /tmp/id
