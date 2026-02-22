CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS sales (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  created_at timestamptz NOT NULL DEFAULT now(),
  type text NOT NULL,
  name text NOT NULL,
  cost numeric(12,2) NOT NULL DEFAULT 0,
  price numeric(12,2) NOT NULL DEFAULT 0,
  cashier text
);

CREATE TABLE IF NOT EXISTS leads (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  created_at timestamptz NOT NULL DEFAULT now(),
  source text,
  device text,
  status text,
  is_closed boolean NOT NULL DEFAULT false
);

CREATE TABLE IF NOT EXISTS tasks (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  created_at timestamptz NOT NULL DEFAULT now(),
  deadline timestamptz,
  assignee text,
  task_type text NOT NULL DEFAULT 'ops',
  title text NOT NULL,
  status text NOT NULL DEFAULT 'new',
  result text,
  reminded_at timestamptz
);

CREATE TABLE IF NOT EXISTS stock (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  sku_or_name text NOT NULL,
  category text,
  qty integer NOT NULL DEFAULT 0,
  min_qty integer NOT NULL DEFAULT 0,
  supplier text,
  cost_price numeric(12,2) NOT NULL DEFAULT 0,
  sell_price numeric(12,2) NOT NULL DEFAULT 0
);

CREATE TABLE IF NOT EXISTS expenses (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  created_at timestamptz NOT NULL DEFAULT now(),
  category text NOT NULL,
  amount numeric(12,2) NOT NULL DEFAULT 0,
  comment text
);

CREATE TABLE IF NOT EXISTS rules (
  key text PRIMARY KEY,
  value text NOT NULL
);

CREATE TABLE IF NOT EXISTS logs (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  created_at timestamptz NOT NULL DEFAULT now(),
  agent text NOT NULL,
  action text NOT NULL,
  details jsonb NOT NULL DEFAULT '{}'::jsonb,
  result text NOT NULL DEFAULT 'OK'
);

INSERT INTO rules(key, value) VALUES
  ('timezone','Europe/Moscow'),
  ('daily_report_time','20:15'),
  ('director_cycle_minutes','15'),
  ('overdue_remind_after_minutes','120'),
  ('task_message_format','list'),
  ('reorder_rule','MINX2'),
  ('staff_list','Артур|Игорь|Витя|Никита'),
  ('expense_categories','аренда|зарплата|налоги|кредиты|расходы')
ON CONFLICT (key) DO NOTHING;
