percol Cookbook
===============
Chef cookbook for [percol](https://github.com/mooz/percol)

Requirements
------------
#### Cookbooks
- [python](http://community.opscode.com/cookbooks/python)

Attributes
----------
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['percol']['users']</tt></td>
    <td>Allay</td>
    <td>users to apply percols' rc.py</td>
    <td><tt>[]</tt></td>
  </tr>
</table>

Usage
-----
Define users who wants to use percol and include `percol` in your node's `run_list`:

```json
{
  "percol": {
    "users": ["user1","user2"]
  },
  "run_list": [
    "recipe[percol]"
  ]
}
```

NOTE: If defined user uses zsh as login shell, zsh history search using percol will be automatically enabled.

Contributing
------------

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Kuniaki Shimizu <k.shimizu@8d1w.com>
