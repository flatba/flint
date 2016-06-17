if auth.extra.raw_info.birthday
    user.birthday = Date.strptime(auth.extra.raw_info.birthday, '%m/%d/%Y')
end
