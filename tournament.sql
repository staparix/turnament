DROP DATABASE IF EXISTS tournament;
CREATE DATABASE tournament;
\c tournament

-- DROP TABLE IF EXISTS Players CASCADE;
-- DROP TABLE IF EXISTS Matches CASCADE;

CREATE TABLE Players (
  id       SERIAL       NOT NULL,
  fullname VARCHAR(120) NOT NULL,

  CONSTRAINT players_pkc PRIMARY KEY (id),
  CONSTRAINT players_fullname_uniq UNIQUE (fullname)
);

CREATE TABLE Matches (
  id  SERIAL  NOT NULL,
  winner INTEGER NOT NULL,
  loser INTEGER NOT NULL,
  CONSTRAINT id_pkc PRIMARY KEY (id),
  CONSTRAINT won_fkc FOREIGN KEY (winner) REFERENCES Players (id),
  CONSTRAINT lose_fkc FOREIGN KEY (loser) REFERENCES Players (id)
);


CREATE VIEW standings AS select p.id,p.fullname,sum(case when p.id = m.winner THEN 1 ELSE 0 END) as wins ,count(m.*) AS total
FROM players p
LEFT JOIN matches m ON (p.id = m.winner OR p.id = m.loser)
GROUP BY p.fullname,p.id
ORDER BY wins DESC ;

-- MOC DATA
--
-- insert into Players(fullname) VALUES ('A');
-- insert into Players(fullname) VALUES ('B');
-- insert into Players(fullname) VALUES ('C');
-- insert into Players(fullname) VALUES ('D');
-- insert into Players(fullname) VALUES ('E');
-- insert into Players(fullname) VALUES ('F');
-- insert into Players(fullname) VALUES ('G');
-- insert into Players(fullname) VALUES ('H');

-- FIRST ROUND

-- insert into Matches(winner, loser ) VALUES (1,2);
-- insert into Matches(winner, loser ) VALUES (3,4);
-- insert into Matches(winner, loser ) VALUES (5,6);
-- insert into Matches(winner, loser ) VALUES (7,8);

-- SECOND ROUND
-- insert into Matches(winner, loser ) VALUES (1,3);
-- insert into Matches(winner, loser ) VALUES (5,7);
-- insert into Matches(winner, loser ) VALUES (2,4);
-- insert into Matches(winner, loser ) VALUES (6,8);

-- select p.id,p.fullname,sum(case when p.id = m.winner THEN 1 ELSE 0 END) as wins ,count(m.*) AS total
-- FROM players p
-- LEFT JOIN matches m ON (p.id = m.winner OR p.id = m.loser)
-- GROUP BY p.fullname,p.id
-- ORDER BY wins DESC ;