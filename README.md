# learn_flutter_supabase

- Create account Supabase : https://supabase.com/
### - Create Table Example :
```-- Create the table
create table products (
  id bigint primary key generated always as identity,
  name text not null
);
-- Insert some sample data into the table
insert into products (name)
values
  ('Bagpack'),
  ('Tracking Pole'),
  ('Dome Tent');

alter table products enable row level security;
```

### - Setup table to public : 
```create policy "public can read products"
on public.products
for select to anon
using (true);
```

