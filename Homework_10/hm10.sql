CREATE INDEX profiles_fn_ln_pn_idx ON profiles(first_name, last_name, patronymic_name);
CREATE INDEX communities_users_u_idx ON communities_users(user_id);
CREATE INDEX communities_n_idx ON communities(name);
CREATE INDEX media_f_u_idx ON media(user_id, filename);
CREATE UNIQUE INDEX friendship_u_f_idx ON friendship(user_id, friend_id);
CREATE INDEX profiles_fn_ln_pn_c_idx ON profiles(first_name, last_name, patronymic_name, city);
CREATE INDEX profiles_fn_ln_c_idx ON profiles(first_name, last_name, city);
CREATE INDEX profiles_fn_ln_g_idx ON profiles(first_name, last_name, gender_id);
CREATE INDEX profiles_c_g_idx ON profiles(city, gender_id);
CREATE INDEX posts_u_c_idx ON posts(user_id, community_id);
CREATE INDEX messages_f_t_idx ON messages(from_user_id, to_user_id);

-- ока не получилось сделать второе задание