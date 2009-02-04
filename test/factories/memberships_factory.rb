
Factory.define :membership do |f|
  f.user    { Factory(:user)    }
  f.project { Factory(:project) }
  f.role 'normal'
end
