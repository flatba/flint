if auth.extra.raw_info.birthday
        omniuser.birthday = Date.strptime(auth.extra.raw_info.birthday, '%m/%d/%Y')
end
