1. SELECT `boosterpack_id`, HOUR(`time_created`) as 'hour', DAY(`time_created`) as 'day', SUM(`amount`) as 'sum', SUM(`items`.`price`) as 'user_receive'
   FROM `analytics`

       INNER JOIN `boosterpack_info` ON `boosterpack_info`.`id` = `object_id`
       INNER JOIN `items` ON `items`.`id` = `boosterpack_info`.`item_id`

   WHERE `object` = 1 AND `time_created` >= DATE(NOW()) - INTERVAL 30 DAY
   GROUP BY `boosterpack_id`, HOUR(`time_created`), DAY(`time_created`);


2. SELECT `id`, `email`, `wallet_total_refilled`, `wallet_balance`, `likes_balance`,
      (
          (SELECT IFNULL(SUM(`likes`), 0) FROM `post` WHERE `user_id` = `user`.`id`) +
          (SELECT IFNULL(SUM(`likes`), 0) FROM `comment` WHERE `user_id` = `user`.`id`)
      ) as `total_like` FROM `user`;

2. SELECT `id`, `email`, `wallet_total_refilled`, `wallet_balance`, `likes_balance`,
      (SELECT SUM(`union`.`likes`) FROM (
            SELECT `likes`, `user_id` FROM `comment`
            UNION ALL
            SELECT `likes`, `user_id` FROM `post`
        ) `union` WHERE `user_id` = `user`.`id`
      ) AS `total_like`
   FROM `user`;