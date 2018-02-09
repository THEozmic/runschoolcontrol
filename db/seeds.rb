require 'digest/md5'

schools = School.create([
    {name: 'fbc', password: '1234', username: 'fbc_admin'},
    {name: 'rsm', password: '1234', username: 'rsm_admin'},
    {name: 'tcs', password: '1234', username: 'tcs_admin'},
])