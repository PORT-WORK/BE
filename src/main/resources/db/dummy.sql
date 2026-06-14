-- PORT dummy data seed



BEGIN;







-- Missing tables in current entity set



CREATE TABLE IF NOT EXISTS teams (



  id BIGSERIAL PRIMARY KEY,



  name VARCHAR(100) NOT NULL,



  description TEXT,



  created_at TIMESTAMP NOT NULL DEFAULT NOW(),



  updated_at TIMESTAMP NOT NULL DEFAULT NOW(),



  deleted_at TIMESTAMP NULL



);



CREATE TABLE IF NOT EXISTS team_members (



  id BIGSERIAL PRIMARY KEY,



  team_id BIGINT NOT NULL REFERENCES teams(id),



  user_id BIGINT NOT NULL REFERENCES users(id),



  role VARCHAR(20) NOT NULL,



  created_at TIMESTAMP NOT NULL DEFAULT NOW(),



  updated_at TIMESTAMP NOT NULL DEFAULT NOW()



);



CREATE TABLE IF NOT EXISTS documents (



  id BIGSERIAL PRIMARY KEY,



  team_id BIGINT REFERENCES teams(id),



  owner_id BIGINT NOT NULL REFERENCES users(id),



  title VARCHAR(200) NOT NULL,



  category VARCHAR(50) NOT NULL,



  summary TEXT,



  order_index INT,



  created_at TIMESTAMP NOT NULL DEFAULT NOW(),



  updated_at TIMESTAMP NOT NULL DEFAULT NOW(),



  deleted_at TIMESTAMP NULL



);



CREATE TABLE IF NOT EXISTS document_members (



  id BIGSERIAL PRIMARY KEY,



  document_id BIGINT NOT NULL REFERENCES documents(id),



  user_id BIGINT NOT NULL REFERENCES users(id),



  role VARCHAR(20) NOT NULL,



  created_at TIMESTAMP NOT NULL DEFAULT NOW(),



  updated_at TIMESTAMP NOT NULL DEFAULT NOW()



);



CREATE TABLE IF NOT EXISTS comments (



  id BIGSERIAL PRIMARY KEY,



  document_id BIGINT NOT NULL REFERENCES documents(id),



  user_id BIGINT NOT NULL REFERENCES users(id),



  parent_comment_id BIGINT REFERENCES comments(id),



  content TEXT NOT NULL,



  created_at TIMESTAMP NOT NULL DEFAULT NOW(),



  updated_at TIMESTAMP NOT NULL DEFAULT NOW(),



  deleted_at TIMESTAMP NULL



);



CREATE TABLE IF NOT EXISTS sse_connection_history (



  id BIGSERIAL PRIMARY KEY,



  user_id BIGINT NOT NULL REFERENCES users(id),



  channel VARCHAR(50) NOT NULL,



  connected_at TIMESTAMP NOT NULL,



  disconnected_at TIMESTAMP NULL,



  last_event_id VARCHAR(100),



  created_at TIMESTAMP NOT NULL DEFAULT NOW(),



  updated_at TIMESTAMP NOT NULL DEFAULT NOW()



);



CREATE TABLE IF NOT EXISTS realtime_events (



  id BIGSERIAL PRIMARY KEY,



  user_id BIGINT NOT NULL REFERENCES users(id),



  event_type VARCHAR(50) NOT NULL,



  payload JSONB NOT NULL,



  created_at TIMESTAMP NOT NULL DEFAULT NOW(),



  updated_at TIMESTAMP NOT NULL DEFAULT NOW()



);







INSERT INTO users (id, email, name, profile_image_url, tier, location, experience_years, bio, language, ai_usage_count, is_email_public, noti_email, noti_push, noti_message, created_at, updated_at, deleted_at) VALUES



(1, 'junho.kim@port.kr', '김준호', 'https://i.pravatar.cc/150?img=1', 'FREE', '서울 강남구', 2, '프로젝트 문서와 협업 흐름을 정리하는 일을 좋아합니다.', 'ko', 2, TRUE, TRUE, FALSE, TRUE, '2026-06-01 09:00:00', '2026-06-01 09:30:00', NULL),



(2, 'seoyeon.park@port.kr', '박서연', 'https://i.pravatar.cc/150?img=2', 'PRO', '서울 마포구', 3, 'PM 관점에서 일정과 요구사항을 함께 맞춰가는 편입니다.', 'ko', 5, TRUE, TRUE, TRUE, TRUE, '2026-06-02 09:00:00', '2026-06-02 09:30:00', NULL),



(3, 'minjae.lee@port.kr', '이민재', 'https://i.pravatar.cc/150?img=3', 'FREE', '성남 분당구', 4, 'I enjoy shaping UI and document structure at the same time.', 'en', 1, FALSE, TRUE, FALSE, TRUE, '2026-06-03 09:00:00', '2026-06-03 09:30:00', NULL),



(4, 'yujin.choi@port.kr', '최유진', 'https://i.pravatar.cc/150?img=4', 'PRO', '수원 영통구', 5, '사용자 경험과 배포 품질을 함께 체크하고 싶습니다.', 'ko', 4, TRUE, FALSE, TRUE, TRUE, '2026-06-04 09:00:00', '2026-06-04 09:30:00', NULL),



(5, 'haneul.jung@port.kr', '정하늘', 'https://i.pravatar.cc/150?img=5', 'FREE', '서울 송파구', 6, 'UI를 깔끌하게 정리하고 실무에 바로 쓰는 문서를 선호합니다.', 'ko', 3, FALSE, TRUE, FALSE, TRUE, '2026-06-05 09:00:00', '2026-06-05 09:30:00', NULL),



(6, 'minsu.kang@port.kr', '강민수', 'https://i.pravatar.cc/150?img=6', 'FREE', '인천 연수구', 7, 'I often align API behavior with screen states.', 'en', 6, TRUE, TRUE, FALSE, TRUE, '2026-06-06 09:00:00', '2026-06-06 09:30:00', NULL),



(7, 'jia.yoon@port.kr', '윤지아', 'https://i.pravatar.cc/150?img=7', 'PRO', '서울 종로구', 8, 'Figma와 Notion을 연결해 작업 흐름을 정리하는 데 관심이 많습니다.', 'ko', 2, FALSE, FALSE, TRUE, TRUE, '2026-06-07 09:00:00', '2026-06-07 09:30:00', NULL),



(8, 'doyun.han@port.kr', '한도윤', 'https://i.pravatar.cc/150?img=8', 'FREE', '대전 유성구', 9, '작은 기능도 실제 서비스처럼 보이도록 다듬는 편입니다.', 'ko', 1, TRUE, TRUE, FALSE, TRUE, '2026-06-08 09:00:00', '2026-06-08 09:30:00', NULL),



(9, 'sea.oh@port.kr', '오세아', 'https://i.pravatar.cc/150?img=9', 'PRO', '부산 해운대구', 10, 'I usually manage documentation and release notes together.', 'en', 7, FALSE, TRUE, TRUE, TRUE, '2026-06-09 09:00:00', '2026-06-09 09:30:00', NULL),



(10, 'jiwoo.lim@port.kr', '임지우', 'https://i.pravatar.cc/150?img=10', 'FREE', '서울 서초구', 11, '협업 기록을 포트폴리오로 잘 남기는 것을 중요히 생각합니다.', 'ko', 2, TRUE, FALSE, FALSE, TRUE, '2026-06-10 09:00:00', '2026-06-10 09:30:00', NULL),



(11, 'jihun.seo@port.kr', '서지훈', 'https://i.pravatar.cc/150?img=11', 'FREE', '서울 강남구', 12, '프로젝트 문서와 협업 흐름을 정리하는 일을 좋아합니다.', 'ko', 8, TRUE, TRUE, TRUE, TRUE, '2026-06-11 09:00:00', '2026-06-11 09:30:00', NULL),



(12, 'yeeun.shin@port.kr', '신예은', 'https://i.pravatar.cc/150?img=12', 'PRO', '서울 마포구', 1, 'I focus on timelines and requirements from a PM perspective.', 'en', 3, FALSE, TRUE, FALSE, TRUE, '2026-06-12 09:00:00', '2026-06-12 09:30:00', NULL),



(13, 'taehyun.moon@port.kr', '문태현', 'https://i.pravatar.cc/150?img=13', 'FREE', '성남 분당구', 2, '프론트엔드와 문서 구조를 동시에 다듬는 작업에 익숙합니다.', 'ko', 4, TRUE, FALSE, TRUE, TRUE, '2026-06-13 09:00:00', '2026-06-13 09:30:00', NULL),



(14, 'yuna.cho@port.kr', '조유나', 'https://i.pravatar.cc/150?img=14', 'FREE', '수원 영통구', 3, '사용자 경험과 배포 품질을 함께 체크하고 싶습니다.', 'ko', 2, FALSE, TRUE, FALSE, TRUE, '2026-06-14 09:00:00', '2026-06-14 09:30:00', NULL),



(15, 'junyoung.bae@port.kr', '배준영', 'https://i.pravatar.cc/150?img=15', 'PRO', '서울 송파구', 4, 'I prefer clean interfaces and documents that are usable in real teams.', 'en', 9, TRUE, TRUE, TRUE, TRUE, '2026-06-15 09:00:00', '2026-06-15 09:30:00', NULL),



(16, 'serin.hong@port.kr', '홍세린', 'https://i.pravatar.cc/150?img=16', 'FREE', '인천 연수구', 5, 'API와 화면 상태를 맞추는 작업을 자주 맞습니다.', 'ko', 1, FALSE, FALSE, FALSE, TRUE, '2026-06-16 09:00:00', '2026-06-16 09:30:00', NULL),



(17, 'minho.cha@port.kr', '차민호', 'https://i.pravatar.cc/150?img=17', 'PRO', '서울 종로구', 6, 'Figma와 Notion을 연결해 작업 흐름을 정리하는 데 관심이 많습니다.', 'ko', 5, TRUE, TRUE, TRUE, TRUE, '2026-06-17 09:00:00', '2026-06-17 09:30:00', NULL),



(18, 'naeun.back@port.kr', '백나은', 'https://i.pravatar.cc/150?img=18', 'FREE', '대전 유성구', 7, 'I like polishing even small features so they feel production ready.', 'en', 2, FALSE, TRUE, FALSE, TRUE, '2026-06-18 09:00:00', '2026-06-18 09:30:00', NULL),



(19, 'hyunwoo.song@port.kr', '송현우', 'https://i.pravatar.cc/150?img=19', 'FREE', '부산 해운대구', 8, '문서화와 릴리스 노트를 함께 관리하는 스타일입니다.', 'ko', 4, TRUE, TRUE, TRUE, TRUE, '2026-06-19 09:00:00', '2026-06-19 09:30:00', NULL),



(20, 'dain.kim@port.kr', '김다인', 'https://i.pravatar.cc/150?img=20', 'PRO', '서울 서초구', 9, '협업 기록을 포트폴리오로 잘 남기는 것을 중요히 생각합니다.', 'ko', 3, FALSE, TRUE, TRUE, TRUE, '2026-06-20 09:00:00', '2026-06-20 09:30:00', NULL),



(21, 'seojun.lee@port.kr', '이서준', 'https://i.pravatar.cc/150?img=21', 'FREE', '서울 강남구', 10, 'I like organizing product docs and collaboration flow.', 'en', 2, TRUE, FALSE, FALSE, TRUE, '2026-06-21 09:00:00', '2026-06-21 09:30:00', NULL),



(22, 'harin.choi@port.kr', '최하린', 'https://i.pravatar.cc/150?img=22', 'PRO', '서울 마포구', 11, 'PM 관점에서 일정과 요구사항을 함께 맞춰가는 편입니다.', 'ko', 6, FALSE, TRUE, TRUE, TRUE, '2026-06-22 09:00:00', '2026-06-22 09:30:00', NULL),



(23, 'mingyu.jang@port.kr', '장민규', 'https://i.pravatar.cc/150?img=23', 'FREE', '성남 분당구', 12, '프론트엔드와 문서 구조를 동시에 다듬는 작업에 익숙합니다.', 'ko', 1, TRUE, TRUE, FALSE, TRUE, '2026-06-23 09:00:00', '2026-06-23 09:30:00', NULL),



(24, 'sora.yoon@port.kr', '윤소라', 'https://i.pravatar.cc/150?img=24', 'FREE', '수원 영통구', 1, 'I care about both user experience and release quality.', 'en', 5, FALSE, FALSE, TRUE, TRUE, '2026-06-24 09:00:00', '2026-06-24 09:30:00', NULL),



(25, 'taewu.kim@port.kr', '김태우', 'https://i.pravatar.cc/150?img=25', 'PRO', '서울 송파구', 2, 'UI를 깔끌하게 정리하고 실무에 바로 쓰는 문서를 선호합니다.', 'ko', 7, TRUE, TRUE, TRUE, TRUE, '2026-06-25 09:00:00', '2026-06-25 09:30:00', NULL),



(26, 'yujin.lee@port.kr', '이유진', 'https://i.pravatar.cc/150?img=26', 'FREE', '인천 연수구', 3, 'API와 화면 상태를 맞추는 작업을 자주 맞습니다.', 'ko', 2, FALSE, TRUE, FALSE, TRUE, '2026-06-26 09:00:00', '2026-06-26 09:30:00', NULL),



(27, 'junseo.park@port.kr', '박준서', 'https://i.pravatar.cc/150?img=27', 'FREE', '서울 종로구', 4, 'I enjoy connecting Figma and Notion into a smoother workflow.', 'en', 3, TRUE, TRUE, FALSE, TRUE, '2026-06-27 09:00:00', '2026-06-27 09:30:00', NULL),



(28, 'seoyun.jung@port.kr', '정서윤', 'https://i.pravatar.cc/150?img=28', 'PRO', '대전 유성구', 5, '작은 기능도 실제 서비스처럼 보이도록 다듬는 편입니다.', 'ko', 4, FALSE, FALSE, TRUE, TRUE, '2026-06-28 09:00:00', '2026-06-28 09:30:00', NULL),



(29, 'jihun.o@port.kr', '오지훈', 'https://i.pravatar.cc/150?img=29', 'FREE', '부산 해운대구', 6, '문서화와 릴리스 노트를 함께 관리하는 스타일입니다.', 'ko', 6, TRUE, TRUE, TRUE, TRUE, '2026-06-01 09:00:00', '2026-06-01 09:30:00', NULL),



(30, 'hayoon.shin@port.kr', '설명', 'https://i.pravatar.cc/150?img=30', 'PRO', '설명 설명', 7, '설명 설명 설명 설명 설명.', 'en', 8, FALSE, TRUE, FALSE, TRUE, '2026-06-02 09:00:00', '2026-06-02 09:30:00', NULL);







INSERT INTO oauth_connections (id, user_id, provider, access_token, refresh_token, workspace_url, expires_at) VALUES



(1, 1, 'GITHUB', 'github_access_01', 'github_refresh_01', 'https://github.com/port-user-1/portfolio-2', '2026-12-02 12:00:00'),



(2, 1, 'NOTION', 'notion_access_01', 'notion_refresh_01', 'https://www.notion.so/port/01', '2026-11-02 09:30:00'),



(3, 2, 'GITHUB', 'github_access_02', NULL, 'https://github.com/port-user-2/portfolio-3', '2026-12-03 12:00:00'),



(4, 2, 'NOTION', 'notion_access_02', 'notion_refresh_02', 'https://www.notion.so/port/02', '2026-11-03 09:30:00'),



(5, 2, 'FIGMA', 'figma_access_02', 'figma_refresh_02', 'https://www.figma.com/file/PORT002/portfolio-2', '2026-12-03 12:00:00'),



(6, 3, 'GITHUB', 'github_access_03', 'github_refresh_03', 'https://github.com/port-user-3/portfolio-4', '2026-12-04 12:00:00'),



(7, 4, 'GITHUB', 'github_access_04', NULL, 'https://github.com/port-user-4/portfolio-5', '2026-12-05 12:00:00'),



(8, 4, 'NOTION', 'notion_access_04', 'notion_refresh_04', 'https://www.notion.so/port/04', '2026-11-05 09:30:00'),



(9, 5, 'GITHUB', 'github_access_05', 'github_refresh_05', 'https://github.com/port-user-5/portfolio-1', '2026-12-06 12:00:00'),



(10, 5, 'NOTION', 'notion_access_05', 'notion_refresh_05', 'https://www.notion.so/port/05', '2026-11-06 09:30:00'),



(11, 5, 'FIGMA', 'figma_access_05', 'figma_refresh_05', 'https://www.figma.com/file/PORT005/portfolio-5', '2026-12-06 12:00:00'),



(12, 6, 'GITHUB', 'github_access_06', NULL, 'https://github.com/port-user-6/portfolio-2', '2026-12-07 12:00:00'),



(13, 7, 'GITHUB', 'github_access_07', 'github_refresh_07', 'https://github.com/port-user-7/portfolio-3', '2026-12-08 12:00:00'),



(14, 7, 'NOTION', 'notion_access_07', 'notion_refresh_07', 'https://www.notion.so/port/07', '2026-11-08 09:30:00'),



(15, 8, 'GITHUB', 'github_access_08', NULL, 'https://github.com/port-user-8/portfolio-4', '2026-12-09 12:00:00'),



(16, 8, 'NOTION', 'notion_access_08', 'notion_refresh_08', 'https://www.notion.so/port/08', '2026-11-09 09:30:00'),



(17, 8, 'FIGMA', 'figma_access_08', 'figma_refresh_08', 'https://www.figma.com/file/PORT008/portfolio-8', '2026-12-09 12:00:00'),



(18, 9, 'GITHUB', 'github_access_09', 'github_refresh_09', 'https://github.com/port-user-9/portfolio-5', '2026-12-10 12:00:00'),



(19, 10, 'GITHUB', 'github_access_10', NULL, 'https://github.com/port-user-10/portfolio-1', '2026-12-11 12:00:00'),



(20, 10, 'NOTION', 'notion_access_10', 'notion_refresh_10', 'https://www.notion.so/port/10', '2026-11-11 09:30:00'),



(21, 11, 'GITHUB', 'github_access_11', 'github_refresh_11', 'https://github.com/port-user-11/portfolio-2', '2026-12-12 12:00:00'),



(22, 11, 'NOTION', 'notion_access_11', 'notion_refresh_11', 'https://www.notion.so/port/11', '2026-11-12 09:30:00'),



(23, 11, 'FIGMA', 'figma_access_11', 'figma_refresh_11', 'https://www.figma.com/file/PORT011/portfolio-11', '2026-12-12 12:00:00'),



(24, 12, 'GITHUB', 'github_access_12', NULL, 'https://github.com/port-user-12/portfolio-3', '2026-12-13 12:00:00'),



(25, 13, 'GITHUB', 'github_access_13', 'github_refresh_13', 'https://github.com/port-user-13/portfolio-4', '2026-12-14 12:00:00'),



(26, 13, 'NOTION', 'notion_access_13', 'notion_refresh_13', 'https://www.notion.so/port/13', '2026-11-14 09:30:00'),



(27, 14, 'GITHUB', 'github_access_14', NULL, 'https://github.com/port-user-14/portfolio-5', '2026-12-15 12:00:00'),



(28, 14, 'NOTION', 'notion_access_14', 'notion_refresh_14', 'https://www.notion.so/port/14', '2026-11-15 09:30:00'),



(29, 14, 'FIGMA', 'figma_access_14', 'figma_refresh_14', 'https://www.figma.com/file/PORT014/portfolio-14', '2026-12-15 12:00:00'),



(30, 15, 'GITHUB', 'github_access_15', 'github_refresh_15', 'https://github.com/port-user-15/portfolio-1', '2026-12-16 12:00:00'),



(31, 16, 'GITHUB', 'github_access_16', NULL, 'https://github.com/port-user-16/portfolio-2', '2026-12-17 12:00:00'),



(32, 16, 'NOTION', 'notion_access_16', 'notion_refresh_16', 'https://www.notion.so/port/16', '2026-11-17 09:30:00'),



(33, 17, 'GITHUB', 'github_access_17', 'github_refresh_17', 'https://github.com/port-user-17/portfolio-3', '2026-12-18 12:00:00'),



(34, 17, 'NOTION', 'notion_access_17', 'notion_refresh_17', 'https://www.notion.so/port/17', '2026-11-18 09:30:00'),



(35, 17, 'FIGMA', 'figma_access_17', 'figma_refresh_17', 'https://www.figma.com/file/PORT017/portfolio-17', '2026-12-18 12:00:00'),



(36, 18, 'GITHUB', 'github_access_18', NULL, 'https://github.com/port-user-18/portfolio-4', '2026-12-19 12:00:00'),



(37, 19, 'GITHUB', 'github_access_19', 'github_refresh_19', 'https://github.com/port-user-19/portfolio-5', '2026-12-20 12:00:00'),



(38, 19, 'NOTION', 'notion_access_19', 'notion_refresh_19', 'https://www.notion.so/port/19', '2026-11-20 09:30:00'),



(39, 20, 'GITHUB', 'github_access_20', NULL, 'https://github.com/port-user-20/portfolio-1', '2026-12-21 12:00:00'),



(40, 20, 'NOTION', 'notion_access_20', 'notion_refresh_20', 'https://www.notion.so/port/20', '2026-11-21 09:30:00'),



(41, 20, 'FIGMA', 'figma_access_20', 'figma_refresh_20', 'https://www.figma.com/file/PORT020/portfolio-20', '2026-12-21 12:00:00'),



(42, 21, 'GITHUB', 'github_access_21', 'github_refresh_21', 'https://github.com/port-user-21/portfolio-2', '2026-12-22 12:00:00'),



(43, 22, 'GITHUB', 'github_access_22', NULL, 'https://github.com/port-user-22/portfolio-3', '2026-12-23 12:00:00'),



(44, 22, 'NOTION', 'notion_access_22', 'notion_refresh_22', 'https://www.notion.so/port/22', '2026-11-23 09:30:00'),



(45, 23, 'GITHUB', 'github_access_23', 'github_refresh_23', 'https://github.com/port-user-23/portfolio-4', '2026-12-24 12:00:00'),



(46, 23, 'NOTION', 'notion_access_23', 'notion_refresh_23', 'https://www.notion.so/port/23', '2026-11-24 09:30:00'),



(47, 23, 'FIGMA', 'figma_access_23', 'figma_refresh_23', 'https://www.figma.com/file/PORT023/portfolio-23', '2026-12-24 12:00:00'),



(48, 24, 'GITHUB', 'github_access_24', NULL, 'https://github.com/port-user-24/portfolio-5', '2026-12-25 12:00:00'),



(49, 25, 'GITHUB', 'github_access_25', 'github_refresh_25', 'https://github.com/port-user-25/portfolio-1', '2026-12-26 12:00:00'),



(50, 25, 'NOTION', 'notion_access_25', 'notion_refresh_25', 'https://www.notion.so/port/25', '2026-11-26 09:30:00'),



(51, 26, 'GITHUB', 'github_access_26', NULL, 'https://github.com/port-user-26/portfolio-2', '2026-12-27 12:00:00'),



(52, 26, 'NOTION', 'notion_access_26', 'notion_refresh_26', 'https://www.notion.so/port/26', '2026-11-27 09:30:00'),



(53, 26, 'FIGMA', 'figma_access_26', 'figma_refresh_26', 'https://www.figma.com/file/PORT026/portfolio-26', '2026-12-27 12:00:00'),



(54, 27, 'GITHUB', 'github_access_27', 'github_refresh_27', 'https://github.com/port-user-27/portfolio-3', '2026-12-28 12:00:00'),



(55, 28, 'GITHUB', 'github_access_28', NULL, 'https://github.com/port-user-28/portfolio-4', '2026-12-01 12:00:00'),



(56, 28, 'NOTION', 'notion_access_28', 'notion_refresh_28', 'https://www.notion.so/port/28', '2026-11-01 09:30:00'),



(57, 29, 'GITHUB', 'github_access_29', 'github_refresh_29', 'https://github.com/port-user-29/portfolio-5', '2026-12-02 12:00:00'),



(58, 29, 'NOTION', 'notion_access_29', 'notion_refresh_29', 'https://www.notion.so/port/29', '2026-11-02 09:30:00'),



(59, 29, 'FIGMA', 'figma_access_29', 'figma_refresh_29', 'https://www.figma.com/file/PORT029/portfolio-29', '2026-12-02 12:00:00'),



(60, 30, 'GITHUB', 'github_access_30', NULL, 'https://github.com/port-user-30/portfolio-1', '2026-12-03 12:00:00');







INSERT INTO user_links (id, user_id, platform, url) VALUES



(1, 1, 'FIGMA', 'https://link.port.kr/1/0'),



(2, 1, 'OTHER', 'https://link.port.kr/1/1'),



(3, 2, 'OTHER', 'https://link.port.kr/2/0'),



(4, 2, 'BEHANCE', 'https://link.port.kr/2/1'),



(5, 3, 'BEHANCE', 'https://link.port.kr/3/0'),



(6, 3, 'DRIBBBLE', 'https://link.port.kr/3/1'),



(7, 4, 'DRIBBBLE', 'https://link.port.kr/4/0'),



(8, 4, 'GITHUB', 'https://link.port.kr/4/1'),



(9, 5, 'GITHUB', 'https://link.port.kr/5/0'),



(10, 5, 'FIGMA', 'https://link.port.kr/5/1'),



(11, 6, 'FIGMA', 'https://link.port.kr/6/0'),



(12, 6, 'OTHER', 'https://link.port.kr/6/1'),



(13, 7, 'OTHER', 'https://link.port.kr/7/0'),



(14, 7, 'BEHANCE', 'https://link.port.kr/7/1'),



(15, 8, 'BEHANCE', 'https://link.port.kr/8/0'),



(16, 8, 'DRIBBBLE', 'https://link.port.kr/8/1'),



(17, 9, 'DRIBBBLE', 'https://link.port.kr/9/0'),



(18, 9, 'GITHUB', 'https://link.port.kr/9/1'),



(19, 10, 'GITHUB', 'https://link.port.kr/10/0'),



(20, 10, 'FIGMA', 'https://link.port.kr/10/1'),



(21, 11, 'FIGMA', 'https://link.port.kr/11/0'),



(22, 11, 'OTHER', 'https://link.port.kr/11/1'),



(23, 12, 'OTHER', 'https://link.port.kr/12/0'),



(24, 12, 'BEHANCE', 'https://link.port.kr/12/1'),



(25, 13, 'BEHANCE', 'https://link.port.kr/13/0'),



(26, 13, 'DRIBBBLE', 'https://link.port.kr/13/1'),



(27, 14, 'DRIBBBLE', 'https://link.port.kr/14/0'),



(28, 14, 'GITHUB', 'https://link.port.kr/14/1'),



(29, 15, 'GITHUB', 'https://link.port.kr/15/0'),



(30, 15, 'FIGMA', 'https://link.port.kr/15/1'),



(31, 16, 'FIGMA', 'https://link.port.kr/16/0'),



(32, 16, 'OTHER', 'https://link.port.kr/16/1'),



(33, 17, 'OTHER', 'https://link.port.kr/17/0'),



(34, 17, 'BEHANCE', 'https://link.port.kr/17/1'),



(35, 18, 'BEHANCE', 'https://link.port.kr/18/0'),



(36, 18, 'DRIBBBLE', 'https://link.port.kr/18/1'),



(37, 19, 'DRIBBBLE', 'https://link.port.kr/19/0'),



(38, 19, 'GITHUB', 'https://link.port.kr/19/1'),



(39, 20, 'GITHUB', 'https://link.port.kr/20/0'),



(40, 20, 'FIGMA', 'https://link.port.kr/20/1'),



(41, 21, 'FIGMA', 'https://link.port.kr/21/0'),



(42, 21, 'OTHER', 'https://link.port.kr/21/1'),



(43, 22, 'OTHER', 'https://link.port.kr/22/0'),



(44, 22, 'BEHANCE', 'https://link.port.kr/22/1'),



(45, 23, 'BEHANCE', 'https://link.port.kr/23/0'),



(46, 23, 'DRIBBBLE', 'https://link.port.kr/23/1'),



(47, 24, 'DRIBBBLE', 'https://link.port.kr/24/0'),



(48, 24, 'GITHUB', 'https://link.port.kr/24/1'),



(49, 25, 'GITHUB', 'https://link.port.kr/25/0'),



(50, 25, 'FIGMA', 'https://link.port.kr/25/1'),



(51, 26, 'FIGMA', 'https://link.port.kr/26/0'),



(52, 26, 'OTHER', 'https://link.port.kr/26/1'),



(53, 27, 'OTHER', 'https://link.port.kr/27/0'),



(54, 27, 'BEHANCE', 'https://link.port.kr/27/1'),



(55, 28, 'BEHANCE', 'https://link.port.kr/28/0'),



(56, 28, 'DRIBBBLE', 'https://link.port.kr/28/1'),



(57, 29, 'DRIBBBLE', 'https://link.port.kr/29/0'),



(58, 29, 'GITHUB', 'https://link.port.kr/29/1'),



(59, 30, 'GITHUB', 'https://link.port.kr/30/0'),



(60, 30, 'FIGMA', 'https://link.port.kr/30/1');



INSERT INTO work_experiences (id, user_id, company_name, role, description, start_date, end_date, is_current) VALUES



(1, 1, '이커머스 플랫폼팀', 'Frontend Developer', '문서 정리와 요구사항 검토 흐름을 맞춰 전달했습니다. (이커머스 플랫폼팀)', '2021-01-01', '2021-12-31', FALSE),



(2, 2, '필터인테크 팀', 'Product Manager', '이슈와 회고를 후속으로 정리하며 협업스타일을 정착시켰습니다. (필터인테크 팀)', '2022-01-01', '2022-12-31', FALSE),



(3, 3, '에듀 서비스팀', 'Frontend Developer', '실행 중에 발생한 내용을 깨짐없이 기록하고 공유했습니다. (에듀 서비스팀)', '2023-01-01', '2023-12-31', FALSE),



(4, 4, '문서 협업팀', 'Product Manager', '문서와 상태이 분리되게 정리되도록 구조를 만들었습니다. (문서 협업팀)', '2020-01-01', NULL, TRUE),



(5, 5, '헬스케어 폼팅팀', 'Frontend Developer', '사용자 흐름이 협업 기록으로 잘 연결되도록 도와습니다. (헬스케어 폼팅팀)', '2021-01-01', '2021-12-31', FALSE),



(6, 6, '모비리티 팀', 'Product Manager', '문서 정리와 요구사항 검토 흐름을 맞춰 전달했습니다. (모비리티 팀)', '2022-01-01', '2022-12-31', FALSE),



(7, 7, '설계 에이플로우팀', 'Frontend Developer', '이슈와 회고를 후속으로 정리하며 협업스타일을 정착시켰습니다. (설계 에이플로우팀)', '2023-01-01', '2023-12-31', FALSE),



(8, 8, '컨텐츠 플랫폼팀', 'Product Manager', '실행 중에 발생한 내용을 깨짐없이 기록하고 공유했습니다. (컨텐츠 플랫폼팀)', '2020-01-01', NULL, TRUE),



(9, 9, '직무 관리팀', 'Frontend Developer', '문서와 상태이 분리되게 정리되도록 구조를 만들었습니다. (직무 관리팀)', '2021-01-01', '2021-12-31', FALSE),



(10, 10, '디자인 시스템팀', 'Product Manager', '사용자 흐름이 협업 기록으로 잘 연결되도록 도와습니다. (디자인 시스템팀)', '2022-01-01', '2022-12-31', FALSE),



(11, 11, '이커머스 플랫폼팀', 'Frontend Developer', '문서 정리와 요구사항 검토 흐름을 맞춰 전달했습니다. (이커머스 플랫폼팀)', '2023-01-01', '2023-12-31', FALSE),



(12, 12, '필터인테크 팀', 'Product Manager', '이슈와 회고를 후속으로 정리하며 협업스타일을 정착시켰습니다. (필터인테크 팀)', '2020-01-01', NULL, TRUE),



(13, 13, '에듀 서비스팀', 'Frontend Developer', '실행 중에 발생한 내용을 깨짐없이 기록하고 공유했습니다. (에듀 서비스팀)', '2021-01-01', '2021-12-31', FALSE),



(14, 14, '문서 협업팀', 'Product Manager', '문서와 상태이 분리되게 정리되도록 구조를 만들었습니다. (문서 협업팀)', '2022-01-01', '2022-12-31', FALSE),



(15, 15, '헬스케어 폼팅팀', 'Frontend Developer', '사용자 흐름이 협업 기록으로 잘 연결되도록 도와습니다. (헬스케어 폼팅팀)', '2023-01-01', '2023-12-31', FALSE),



(16, 16, '모비리티 팀', 'Product Manager', '문서 정리와 요구사항 검토 흐름을 맞춰 전달했습니다. (모비리티 팀)', '2020-01-01', NULL, TRUE),



(17, 17, '설계 에이플로우팀', 'Frontend Developer', '이슈와 회고를 후속으로 정리하며 협업스타일을 정착시켰습니다. (설계 에이플로우팀)', '2021-01-01', '2021-12-31', FALSE),



(18, 18, '컨텐츠 플랫폼팀', 'Product Manager', '실행 중에 발생한 내용을 깨짐없이 기록하고 공유했습니다. (컨텐츠 플랫폼팀)', '2022-01-01', '2022-12-31', FALSE),



(19, 19, '직무 관리팀', 'Frontend Developer', '문서와 상태이 분리되게 정리되도록 구조를 만들었습니다. (직무 관리팀)', '2023-01-01', '2023-12-31', FALSE),



(20, 20, '디자인 시스템팀', 'Product Manager', '사용자 흐름이 협업 기록으로 잘 연결되도록 도와습니다. (디자인 시스템팀)', '2020-01-01', NULL, TRUE),



(21, 21, '이커머스 플랫폼팀', 'Frontend Developer', '문서 정리와 요구사항 검토 흐름을 맞춰 전달했습니다. (이커머스 플랫폼팀)', '2021-01-01', '2021-12-31', FALSE),



(22, 22, '필터인테크 팀', 'Product Manager', '이슈와 회고를 후속으로 정리하며 협업스타일을 정착시켰습니다. (필터인테크 팀)', '2022-01-01', '2022-12-31', FALSE),



(23, 23, '에듀 서비스팀', 'Frontend Developer', '실행 중에 발생한 내용을 깨짐없이 기록하고 공유했습니다. (에듀 서비스팀)', '2023-01-01', '2023-12-31', FALSE),



(24, 24, '문서 협업팀', 'Product Manager', '문서와 상태이 분리되게 정리되도록 구조를 만들었습니다. (문서 협업팀)', '2020-01-01', NULL, TRUE),



(25, 25, '헬스케어 폼팅팀', 'Frontend Developer', '사용자 흐름이 협업 기록으로 잘 연결되도록 도와습니다. (헬스케어 폼팅팀)', '2021-01-01', '2021-12-31', FALSE),



(26, 26, '모비리티 팀', 'Product Manager', '문서 정리와 요구사항 검토 흐름을 맞춰 전달했습니다. (모비리티 팀)', '2022-01-01', '2022-12-31', FALSE),



(27, 27, '설계 에이플로우팀', 'Frontend Developer', '이슈와 회고를 후속으로 정리하며 협업스타일을 정착시켰습니다. (설계 에이플로우팀)', '2023-01-01', '2023-12-31', FALSE),



(28, 28, '컨텐츠 플랫폼팀', 'Product Manager', '실행 중에 발생한 내용을 깨짐없이 기록하고 공유했습니다. (컨텐츠 플랫폼팀)', '2020-01-01', NULL, TRUE),



(29, 29, '직무 관리팀', 'Frontend Developer', '문서와 상태이 분리되게 정리되도록 구조를 만들었습니다. (직무 관리팀)', '2021-01-01', '2021-12-31', FALSE),



(30, 30, '디자인 시스템팀', 'Product Manager', '사용자 흐름이 협업 기록으로 잘 연결되도록 도와습니다. (디자인 시스템팀)', '2022-01-01', '2022-12-31', FALSE);



INSERT INTO educations (id, user_id, school_name, major, start_year, end_year, is_attending) VALUES



(1, 1, '서울대학교', '컴퓨터공학과', 2015, 2019, FALSE),



(2, 2, '연세대학교', '경영학과', 2016, 2020, FALSE),



(3, 3, '고려대학교', '산업디자인학과', 2017, 2021, FALSE),



(4, 4, '성균관대학교', '소프트웨어학과', 2018, 2018, FALSE),



(5, 5, '한양대학교', '정보시스템학과', 2019, NULL, TRUE),



(6, 6, '중앙대학교', '미디어커뮤니케이션학과', 2014, 2020, FALSE),



(7, 7, '경희대학교', '컴퓨터공학과', 2015, 2021, FALSE),



(8, 8, '건국대학교', '경영학과', 2016, 2018, FALSE),



(9, 9, '동국대학교', '산업디자인학과', 2017, 2019, FALSE),



(10, 10, '서강대학교', '소프트웨어학과', 2018, NULL, TRUE),



(11, 11, '서울대학교', '정보시스템학과', 2019, 2021, FALSE),



(12, 12, '연세대학교', '미디어커뮤니케이션학과', 2014, 2018, FALSE),



(13, 13, '고려대학교', '컴퓨터공학과', 2015, 2019, FALSE),



(14, 14, '성균관대학교', '경영학과', 2016, 2020, FALSE),



(15, 15, '한양대학교', '산업디자인학과', 2017, NULL, TRUE),



(16, 16, '중앙대학교', '소프트웨어학과', 2018, 2018, FALSE),



(17, 17, '경희대학교', '정보시스템학과', 2019, 2019, FALSE),



(18, 18, '건국대학교', '미디어커뮤니케이션학과', 2014, 2020, FALSE),



(19, 19, '동국대학교', '컴퓨터공학과', 2015, 2021, FALSE),



(20, 20, '서강대학교', '경영학과', 2016, NULL, TRUE),



(21, 21, '서울대학교', '산업디자인학과', 2017, 2019, FALSE),



(22, 22, '연세대학교', '소프트웨어학과', 2018, 2020, FALSE),



(23, 23, '고려대학교', '정보시스템학과', 2019, 2021, FALSE),



(24, 24, '성균관대학교', '미디어커뮤니케이션학과', 2014, 2018, FALSE),



(25, 25, '한양대학교', '컴퓨터공학과', 2015, NULL, TRUE),



(26, 26, '중앙대학교', '경영학과', 2016, 2020, FALSE),



(27, 27, '경희대학교', '산업디자인학과', 2017, 2021, FALSE),



(28, 28, '건국대학교', '소프트웨어학과', 2018, 2018, FALSE),



(29, 29, '동국대학교', '정보시스템학과', 2019, 2019, FALSE),



(30, 30, '설명', '설명', 2014, NULL, TRUE);







INSERT INTO teams (id, name, description) VALUES



(1, 'Docs Crew', '문서와 스파인을 정리하는 팀입니다.'),



(2, 'Backend Study', '비주의 소프트웨어 스터디로 사용합니다.'),



(3, 'Startup Lab', '실제 실무 기반 프로젝트를 구성하는 시도입니다.'),



(4, 'Capstone Team', '학생 팀원들이 살아 이어가는 최종 프로젝트 팀입니다.'),



(5, 'Product Squad', '문서와 스파인을 정리하는 팀입니다.'),



(6, 'Design Sync', '비주의 소프트웨어 스터디로 사용합니다.'),



(7, 'Hiring Prep', '실제 실무 기반 프로젝트를 구성하는 시도입니다.'),



(8, 'PORT Lab', '학생 팀원들이 살아 이어가는 최종 프로젝트 팀입니다.'),



(9, 'Release Team', '문서와 스파인을 정리하는 팀입니다.'),



(10, 'AI Review', '비주의 소프트웨어 스터디로 사용합니다.');







INSERT INTO team_members (id, team_id, user_id, role) VALUES



(1, 1, 1, 'ADMIN'),



(2, 1, 2, 'EDITOR'),



(3, 1, 3, 'VIEWER'),



(4, 2, 4, 'ADMIN'),



(5, 2, 5, 'EDITOR'),



(6, 2, 6, 'VIEWER'),



(7, 3, 7, 'ADMIN'),



(8, 3, 8, 'EDITOR'),



(9, 3, 9, 'VIEWER'),



(10, 4, 10, 'ADMIN'),



(11, 4, 11, 'EDITOR'),



(12, 4, 12, 'VIEWER'),



(13, 5, 13, 'ADMIN'),



(14, 5, 14, 'EDITOR'),



(15, 5, 15, 'VIEWER'),



(16, 6, 16, 'ADMIN'),



(17, 6, 17, 'EDITOR'),



(18, 6, 18, 'VIEWER'),



(19, 7, 19, 'ADMIN'),



(20, 7, 20, 'EDITOR'),



(21, 7, 21, 'VIEWER'),



(22, 8, 22, 'ADMIN'),



(23, 8, 23, 'EDITOR'),



(24, 8, 24, 'VIEWER'),



(25, 9, 25, 'ADMIN'),



(26, 9, 26, 'EDITOR'),



(27, 9, 27, 'VIEWER'),



(28, 10, 28, 'ADMIN'),



(29, 10, 29, 'EDITOR'),



(30, 10, 30, 'VIEWER');







INSERT INTO portfolios (id, user_id, title, job_role, thumbnail_url, summary, skills, template_id, custom_domain, is_public, view_count, like_count, bookmark_count, deleted_at) VALUES



(1, 1, 'PORT 01', 'DEVELOPER', 'https://images.port.kr/portfolio/1.png', '실무 협업 과정과 결과물을 정리한 포트폴리오입니다.', 'React, TypeScript, Node.js', 'template-2', 'portfolio-1.port.kr', FALSE, 107, 21, 9, NULL),



(2, 2, '포트폴리오 02', 'DEVELOPER', 'https://images.port.kr/portfolio/2.png', '문서 작성과 구현 과정을 함께 보여주는 포트폴리오입니다.', 'Figma, Notion, PM', 'template-3', 'portfolio-2.port.kr', TRUE, 114, 22, 10, NULL),



(3, 3, 'WAVEY 03', 'PM', 'https://images.port.kr/portfolio/3.png', 'PM과 개발 관점의 협업 경험을 담은 포트폴리오입니다.', 'React, TypeScript, Node.js', 'template-4', 'portfolio-3.port.kr', FALSE, 121, 23, 11, NULL),



(4, 4, 'MemoReal 04', 'DEVELOPER', 'https://images.port.kr/portfolio/4.png', '디자인과 개발 흐름을 함께 정리한 포트폴리오입니다.', 'Figma, Notion, PM', 'template-1', 'portfolio-4.port.kr', TRUE, 128, 24, 12, NULL),



(5, 5, 'HeyDoctor 05', 'DEVELOPER', 'https://images.port.kr/portfolio/5.png', '실무 협업 과정과 결과물을 정리한 포트폴리오입니다.', 'React, TypeScript, Node.js', 'template-2', 'portfolio-5.port.kr', FALSE, 135, 25, 13, NULL),



(6, 6, 'Campus Map 06', 'PM', 'https://images.port.kr/portfolio/6.png', '문서 작성과 구현 과정을 함께 보여주는 포트폴리오입니다.', 'Figma, Notion, PM', 'template-3', 'portfolio-6.port.kr', TRUE, 142, 26, 8, NULL),



(7, 7, 'StudyHub 07', 'DEVELOPER', 'https://images.port.kr/portfolio/7.png', 'PM과 개발 관점의 협업 경험을 담은 포트폴리오입니다.', 'React, TypeScript, Node.js', 'template-4', 'portfolio-7.port.kr', FALSE, 149, 27, 9, NULL),



(8, 8, 'TeamFlow 08', 'DEVELOPER', 'https://images.port.kr/portfolio/8.png', '디자인과 개발 흐름을 함께 정리한 포트폴리오입니다.', 'Figma, Notion, PM', 'template-1', 'portfolio-8.port.kr', TRUE, 156, 28, 10, NULL),



(9, 9, 'SprintNote 09', 'PM', 'https://images.port.kr/portfolio/9.png', '실무 협업 과정과 결과물을 정리한 포트폴리오입니다.', 'React, TypeScript, Node.js', 'template-2', 'portfolio-9.port.kr', FALSE, 163, 29, 11, NULL),



(10, 10, 'CareerBoard 10', 'DEVELOPER', 'https://images.port.kr/portfolio/10.png', '문서 작성과 구현 과정을 함께 보여주는 포트폴리오입니다.', 'Figma, Notion, PM', 'template-3', 'portfolio-10.port.kr', TRUE, 170, 30, 12, NULL),



(11, 11, 'DevLog 11', 'DEVELOPER', 'https://images.port.kr/portfolio/11.png', 'PM과 개발 관점의 협업 경험을 담은 포트폴리오입니다.', 'React, TypeScript, Node.js', 'template-4', 'portfolio-11.port.kr', FALSE, 177, 31, 13, NULL),



(12, 12, 'PlanMate 12', 'PM', 'https://images.port.kr/portfolio/12.png', '디자인과 개발 흐름을 함께 정리한 포트폴리오입니다.', 'Figma, Notion, PM', 'template-1', 'portfolio-12.port.kr', TRUE, 184, 20, 8, NULL),



(13, 13, 'LaunchPad 13', 'DEVELOPER', 'https://images.port.kr/portfolio/13.png', '실무 협업 과정과 결과물을 정리한 포트폴리오입니다.', 'React, TypeScript, Node.js', 'template-2', 'portfolio-13.port.kr', FALSE, 191, 21, 9, NULL),



(14, 14, 'NexPage 14', 'DEVELOPER', 'https://images.port.kr/portfolio/14.png', '문서 작성과 구현 과정을 함께 보여주는 포트폴리오입니다.', 'Figma, Notion, PM', 'template-3', 'portfolio-14.port.kr', TRUE, 198, 22, 10, NULL),



(15, 15, 'ProtoLab 15', 'PM', 'https://images.port.kr/portfolio/15.png', 'PM과 개발 관점의 협업 경험을 담은 포트폴리오입니다.', 'React, TypeScript, Node.js', 'template-4', 'portfolio-15.port.kr', FALSE, 205, 23, 11, NULL),



(16, 16, 'TaskLens 16', 'DEVELOPER', 'https://images.port.kr/portfolio/16.png', '디자인과 개발 흐름을 함께 정리한 포트폴리오입니다.', 'Figma, Notion, PM', 'template-1', 'portfolio-16.port.kr', TRUE, 212, 24, 12, NULL),



(17, 17, 'DailyProof 17', 'DEVELOPER', 'https://images.port.kr/portfolio/17.png', '실무 협업 과정과 결과물을 정리한 포트폴리오입니다.', 'React, TypeScript, Node.js', 'template-2', 'portfolio-17.port.kr', FALSE, 219, 25, 13, NULL),



(18, 18, 'LinkSync 18', 'PM', 'https://images.port.kr/portfolio/18.png', '문서 작성과 구현 과정을 함께 보여주는 포트폴리오입니다.', 'Figma, Notion, PM', 'template-3', 'portfolio-18.port.kr', TRUE, 226, 26, 8, NULL),



(19, 19, 'FlowNote 19', 'DEVELOPER', 'https://images.port.kr/portfolio/19.png', 'PM과 개발 관점의 협업 경험을 담은 포트폴리오입니다.', 'React, TypeScript, Node.js', 'template-4', 'portfolio-19.port.kr', FALSE, 233, 27, 9, NULL),



(20, 20, 'StackStory 20', 'DEVELOPER', 'https://images.port.kr/portfolio/20.png', '디자인과 개발 흐름을 함께 정리한 포트폴리오입니다.', 'Figma, Notion, PM', 'template-1', 'portfolio-20.port.kr', TRUE, 240, 28, 10, NULL),



(21, 21, 'PORT 21', 'PM', 'https://images.port.kr/portfolio/21.png', '실무 협업 과정과 결과물을 정리한 포트폴리오입니다.', 'React, TypeScript, Node.js', 'template-2', 'portfolio-21.port.kr', FALSE, 247, 29, 11, NULL),



(22, 22, '포트폴리오 22', 'DEVELOPER', 'https://images.port.kr/portfolio/22.png', '문서 작성과 구현 과정을 함께 보여주는 포트폴리오입니다.', 'Figma, Notion, PM', 'template-3', 'portfolio-22.port.kr', TRUE, 254, 30, 12, NULL),



(23, 23, 'WAVEY 23', 'DEVELOPER', 'https://images.port.kr/portfolio/23.png', 'PM과 개발 관점의 협업 경험을 담은 포트폴리오입니다.', 'React, TypeScript, Node.js', 'template-4', 'portfolio-23.port.kr', FALSE, 261, 31, 13, NULL),



(24, 24, 'MemoReal 24', 'PM', 'https://images.port.kr/portfolio/24.png', '디자인과 개발 흐름을 함께 정리한 포트폴리오입니다.', 'Figma, Notion, PM', 'template-1', 'portfolio-24.port.kr', TRUE, 268, 20, 8, NULL),



(25, 25, 'HeyDoctor 25', 'DEVELOPER', 'https://images.port.kr/portfolio/25.png', 'HeyDoctor 25 설명 설명', 'React, TypeScript, Node.js', 'template-2', 'portfolio-25.port.kr', FALSE, 275, 21, 9, NULL);



INSERT INTO portfolios (id, user_id, title, job_role, thumbnail_url, summary, skills, template_id, custom_domain, is_public, view_count, like_count, bookmark_count, deleted_at) VALUES



(26, 26, 'Campus Map 26', 'DEVELOPER', 'https://images.port.kr/portfolio/26.png', '문서 작성과 구현 과정을 함께 보여주는 포트폴리오입니다.', 'Figma, Notion, PM', 'template-3', 'portfolio-26.port.kr', TRUE, 282, 22, 10, NULL),



(27, 27, 'StudyHub 27', 'PM', 'https://images.port.kr/portfolio/27.png', 'PM과 개발 관점의 협업 경험을 담은 포트폴리오입니다.', 'React, TypeScript, Node.js', 'template-4', 'portfolio-27.port.kr', FALSE, 289, 23, 11, NULL),



(28, 28, 'TeamFlow 28', 'DEVELOPER', 'https://images.port.kr/portfolio/28.png', '디자인과 개발 흐름을 함께 정리한 포트폴리오입니다.', 'Figma, Notion, PM', 'template-1', 'portfolio-28.port.kr', TRUE, 296, 24, 12, NULL),



(29, 29, 'SprintNote 29', 'DEVELOPER', 'https://images.port.kr/portfolio/29.png', '실무 협업 과정과 결과물을 정리한 포트폴리오입니다.', 'React, TypeScript, Node.js', 'template-2', 'portfolio-29.port.kr', FALSE, 303, 25, 13, NULL),



(30, 30, 'CareerBoard 30', 'PM', 'https://images.port.kr/portfolio/30.png', '문서 작성과 구현 과정을 함께 보여주는 포트폴리오입니다.', 'Figma, Notion, PM', 'template-3', 'portfolio-30.port.kr', TRUE, 310, 26, 8, NULL),



(31, 1, 'DevLog 31', 'DEVELOPER', 'https://images.port.kr/portfolio/31.png', 'PM과 개발 관점의 협업 경험을 담은 포트폴리오입니다.', 'React, TypeScript, Node.js', 'template-4', 'portfolio-31.port.kr', FALSE, 317, 27, 9, NULL),



(32, 2, 'PlanMate 32', 'DEVELOPER', 'https://images.port.kr/portfolio/32.png', '디자인과 개발 흐름을 함께 정리한 포트폴리오입니다.', 'Figma, Notion, PM', 'template-1', 'portfolio-32.port.kr', TRUE, 324, 28, 10, NULL),



(33, 3, 'LaunchPad 33', 'PM', 'https://images.port.kr/portfolio/33.png', '실무 협업 과정과 결과물을 정리한 포트폴리오입니다.', 'React, TypeScript, Node.js', 'template-2', 'portfolio-33.port.kr', FALSE, 331, 29, 11, NULL),



(34, 4, 'NexPage 34', 'DEVELOPER', 'https://images.port.kr/portfolio/34.png', '문서 작성과 구현 과정을 함께 보여주는 포트폴리오입니다.', 'Figma, Notion, PM', 'template-3', 'portfolio-34.port.kr', TRUE, 338, 30, 12, NULL),



(35, 5, 'ProtoLab 35', 'DEVELOPER', 'https://images.port.kr/portfolio/35.png', 'PM과 개발 관점의 협업 경험을 담은 포트폴리오입니다.', 'React, TypeScript, Node.js', 'template-4', 'portfolio-35.port.kr', FALSE, 345, 31, 13, NULL),



(36, 6, 'TaskLens 36', 'PM', 'https://images.port.kr/portfolio/36.png', '디자인과 개발 흐름을 함께 정리한 포트폴리오입니다.', 'Figma, Notion, PM', 'template-1', 'portfolio-36.port.kr', TRUE, 352, 20, 8, NULL),



(37, 7, 'DailyProof 37', 'DEVELOPER', 'https://images.port.kr/portfolio/37.png', '실무 협업 과정과 결과물을 정리한 포트폴리오입니다.', 'React, TypeScript, Node.js', 'template-2', 'portfolio-37.port.kr', FALSE, 359, 21, 9, NULL),



(38, 8, 'LinkSync 38', 'DEVELOPER', 'https://images.port.kr/portfolio/38.png', '문서 작성과 구현 과정을 함께 보여주는 포트폴리오입니다.', 'Figma, Notion, PM', 'template-3', 'portfolio-38.port.kr', TRUE, 366, 22, 10, NULL),



(39, 9, 'FlowNote 39', 'PM', 'https://images.port.kr/portfolio/39.png', 'PM과 개발 관점의 협업 경험을 담은 포트폴리오입니다.', 'React, TypeScript, Node.js', 'template-4', 'portfolio-39.port.kr', FALSE, 373, 23, 11, NULL),



(40, 10, 'StackStory 40', 'DEVELOPER', 'https://images.port.kr/portfolio/40.png', '디자인과 개발 흐름을 함께 정리한 포트폴리오입니다.', 'Figma, Notion, PM', 'template-1', 'portfolio-40.port.kr', TRUE, 380, 24, 12, NULL),



(41, 11, 'PORT 41', 'DEVELOPER', 'https://images.port.kr/portfolio/41.png', '실무 협업 과정과 결과물을 정리한 포트폴리오입니다.', 'React, TypeScript, Node.js', 'template-2', 'portfolio-41.port.kr', FALSE, 387, 25, 13, NULL),



(42, 12, '포트폴리오 42', 'PM', 'https://images.port.kr/portfolio/42.png', '문서 작성과 구현 과정을 함께 보여주는 포트폴리오입니다.', 'Figma, Notion, PM', 'template-3', 'portfolio-42.port.kr', TRUE, 394, 26, 8, NULL),



(43, 13, 'WAVEY 43', 'DEVELOPER', 'https://images.port.kr/portfolio/43.png', 'PM과 개발 관점의 협업 경험을 담은 포트폴리오입니다.', 'React, TypeScript, Node.js', 'template-4', 'portfolio-43.port.kr', FALSE, 401, 27, 9, NULL),



(44, 14, 'MemoReal 44', 'DEVELOPER', 'https://images.port.kr/portfolio/44.png', '디자인과 개발 흐름을 함께 정리한 포트폴리오입니다.', 'Figma, Notion, PM', 'template-1', 'portfolio-44.port.kr', TRUE, 408, 28, 10, NULL),



(45, 15, 'HeyDoctor 45', 'PM', 'https://images.port.kr/portfolio/45.png', '실무 협업 과정과 결과물을 정리한 포트폴리오입니다.', 'React, TypeScript, Node.js', 'template-2', 'portfolio-45.port.kr', FALSE, 415, 29, 11, NULL),



(46, 16, 'Campus Map 46', 'DEVELOPER', 'https://images.port.kr/portfolio/46.png', '문서 작성과 구현 과정을 함께 보여주는 포트폴리오입니다.', 'Figma, Notion, PM', 'template-3', 'portfolio-46.port.kr', TRUE, 422, 30, 12, NULL),



(47, 17, 'StudyHub 47', 'DEVELOPER', 'https://images.port.kr/portfolio/47.png', 'PM과 개발 관점의 협업 경험을 담은 포트폴리오입니다.', 'React, TypeScript, Node.js', 'template-4', 'portfolio-47.port.kr', FALSE, 429, 31, 13, NULL),



(48, 18, 'TeamFlow 48', 'PM', 'https://images.port.kr/portfolio/48.png', '디자인과 개발 흐름을 함께 정리한 포트폴리오입니다.', 'Figma, Notion, PM', 'template-1', 'portfolio-48.port.kr', TRUE, 436, 20, 8, NULL),



(49, 19, 'SprintNote 49', 'DEVELOPER', 'https://images.port.kr/portfolio/49.png', '실무 협업 과정과 결과물을 정리한 포트폴리오입니다.', 'React, TypeScript, Node.js', 'template-2', 'portfolio-49.port.kr', FALSE, 443, 21, 9, NULL),



(50, 20, 'CareerBoard 50', 'DEVELOPER', 'https://images.port.kr/portfolio/50.png', 'CareerBoard 50 설명 설명', 'Figma, Notion, PM', 'template-3', 'portfolio-50.port.kr', TRUE, 450, 22, 10, NULL);







INSERT INTO projects (id, portfolio_id, name, role, summary, thumbnail_url, skills, is_synced, start_date, end_date, order_index) VALUES



(1, 1, '이커머스 플랫폼 리뉴얼 1', 'PM', '실제 운영 화면과 문서 흐름을 함께 정리한 프로젝트입니다. (PM)', 'https://images.port.kr/project/1.png', 'Notion, Figma, Roadmap', TRUE, '2021-01-01', '2021-12-31', 1),



(2, 1, '사용자 프로필 길들이기 2', 'DEVELOPER', '요구사항, 호스팅, 설계를 구조적으로 다루는 프로젝트입니다. (DEVELOPER)', 'https://images.port.kr/project/2.png', 'React, TypeScript, Spring Boot', FALSE, '2022-01-01', '2022-12-31', 2),



(3, 2, '문서 협업 개선 3', 'DEVELOPER', '상태와 결과가 한눈에 보이도록 정리한 프로젝트입니다. (DEVELOPER)', 'https://images.port.kr/project/3.png', 'React, TypeScript, Spring Boot', TRUE, '2023-01-01', '2023-12-31', 1),



(4, 2, '어드민스 대시보드 4', 'PM', '실제 운영 화면과 문서 흐름을 함께 정리한 프로젝트입니다. (PM)', 'https://images.port.kr/project/4.png', 'Notion, Figma, Roadmap', FALSE, '2020-01-01', '2020-12-31', 2),



(5, 3, '플랜너 설계 5', 'PM', '요구사항, 호스팅, 설계를 구조적으로 다루는 프로젝트입니다. (PM)', 'https://images.port.kr/project/5.png', 'Notion, Figma, Roadmap', TRUE, '2021-01-01', '2021-12-31', 1),



(6, 3, '기술 구조 정리 6', 'DEVELOPER', '상태와 결과가 한눈에 보이도록 정리한 프로젝트입니다. (DEVELOPER)', 'https://images.port.kr/project/6.png', 'React, TypeScript, Spring Boot', FALSE, '2022-01-01', '2022-12-31', 2),



(7, 4, '회고 기록 시스템 7', 'DEVELOPER', '실제 운영 화면과 문서 흐름을 함께 정리한 프로젝트입니다. (DEVELOPER)', 'https://images.port.kr/project/7.png', 'React, TypeScript, Spring Boot', TRUE, '2023-01-01', '2023-12-31', 1),



(8, 4, '모바일 앱 개발 8', 'PM', '요구사항, 호스팅, 설계를 구조적으로 다루는 프로젝트입니다. (PM)', 'https://images.port.kr/project/8.png', 'Notion, Figma, Roadmap', FALSE, '2020-01-01', '2020-12-31', 2),



(9, 5, '콘텐트 구조 전환 9', 'PM', '상태와 결과가 한눈에 보이도록 정리한 프로젝트입니다. (PM)', 'https://images.port.kr/project/9.png', 'Notion, Figma, Roadmap', TRUE, '2021-01-01', '2021-12-31', 1),



(10, 5, '집중도 개선 10', 'DEVELOPER', '실제 운영 화면과 문서 흐름을 함께 정리한 프로젝트입니다. (DEVELOPER)', 'https://images.port.kr/project/10.png', 'React, TypeScript, Spring Boot', FALSE, '2022-01-01', '2022-12-31', 2),



(11, 6, '이커머스 플랫폼 리뉴얼 11', 'DEVELOPER', '요구사항, 호스팅, 설계를 구조적으로 다루는 프로젝트입니다. (DEVELOPER)', 'https://images.port.kr/project/11.png', 'React, TypeScript, Spring Boot', TRUE, '2023-01-01', '2023-12-31', 1),



(12, 6, '사용자 프로필 길들이기 12', 'PM', '상태와 결과가 한눈에 보이도록 정리한 프로젝트입니다. (PM)', 'https://images.port.kr/project/12.png', 'Notion, Figma, Roadmap', FALSE, '2020-01-01', '2020-12-31', 2),



(13, 7, '문서 협업 개선 13', 'PM', '실제 운영 화면과 문서 흐름을 함께 정리한 프로젝트입니다. (PM)', 'https://images.port.kr/project/13.png', 'Notion, Figma, Roadmap', TRUE, '2021-01-01', '2021-12-31', 1),



(14, 7, '어드민스 대시보드 14', 'DEVELOPER', '요구사항, 호스팅, 설계를 구조적으로 다루는 프로젝트입니다. (DEVELOPER)', 'https://images.port.kr/project/14.png', 'React, TypeScript, Spring Boot', FALSE, '2022-01-01', '2022-12-31', 2),



(15, 8, '플랜너 설계 15', 'DEVELOPER', '상태와 결과가 한눈에 보이도록 정리한 프로젝트입니다. (DEVELOPER)', 'https://images.port.kr/project/15.png', 'React, TypeScript, Spring Boot', TRUE, '2023-01-01', '2023-12-31', 1),



(16, 8, '기술 구조 정리 16', 'PM', '실제 운영 화면과 문서 흐름을 함께 정리한 프로젝트입니다. (PM)', 'https://images.port.kr/project/16.png', 'Notion, Figma, Roadmap', FALSE, '2020-01-01', '2020-12-31', 2),



(17, 9, '회고 기록 시스템 17', 'PM', '요구사항, 호스팅, 설계를 구조적으로 다루는 프로젝트입니다. (PM)', 'https://images.port.kr/project/17.png', 'Notion, Figma, Roadmap', TRUE, '2021-01-01', '2021-12-31', 1),



(18, 9, '모바일 앱 개발 18', 'DEVELOPER', '상태와 결과가 한눈에 보이도록 정리한 프로젝트입니다. (DEVELOPER)', 'https://images.port.kr/project/18.png', 'React, TypeScript, Spring Boot', FALSE, '2022-01-01', '2022-12-31', 2),



(19, 10, '콘텐트 구조 전환 19', 'DEVELOPER', '실제 운영 화면과 문서 흐름을 함께 정리한 프로젝트입니다. (DEVELOPER)', 'https://images.port.kr/project/19.png', 'React, TypeScript, Spring Boot', TRUE, '2023-01-01', '2023-12-31', 1),



(20, 10, '집중도 개선 20', 'PM', '요구사항, 호스팅, 설계를 구조적으로 다루는 프로젝트입니다. (PM)', 'https://images.port.kr/project/20.png', 'Notion, Figma, Roadmap', FALSE, '2020-01-01', '2020-12-31', 2),



(21, 11, '이커머스 플랫폼 리뉴얼 21', 'PM', '상태와 결과가 한눈에 보이도록 정리한 프로젝트입니다. (PM)', 'https://images.port.kr/project/21.png', 'Notion, Figma, Roadmap', TRUE, '2021-01-01', '2021-12-31', 1),



(22, 11, '사용자 프로필 길들이기 22', 'DEVELOPER', '실제 운영 화면과 문서 흐름을 함께 정리한 프로젝트입니다. (DEVELOPER)', 'https://images.port.kr/project/22.png', 'React, TypeScript, Spring Boot', FALSE, '2022-01-01', '2022-12-31', 2),



(23, 12, '문서 협업 개선 23', 'DEVELOPER', '요구사항, 호스팅, 설계를 구조적으로 다루는 프로젝트입니다. (DEVELOPER)', 'https://images.port.kr/project/23.png', 'React, TypeScript, Spring Boot', TRUE, '2023-01-01', '2023-12-31', 1),



(24, 12, '어드민스 대시보드 24', 'PM', '상태와 결과가 한눈에 보이도록 정리한 프로젝트입니다. (PM)', 'https://images.port.kr/project/24.png', 'Notion, Figma, Roadmap', FALSE, '2020-01-01', '2020-12-31', 2),



(25, 13, '플랜너 설계 25', 'PM', '실제 운영 화면과 문서 흐름을 함께 정리한 프로젝트입니다. (PM)', 'https://images.port.kr/project/25.png', 'Notion, Figma, Roadmap', TRUE, '2021-01-01', '2021-12-31', 1),



(26, 13, '기술 구조 정리 26', 'DEVELOPER', '요구사항, 호스팅, 설계를 구조적으로 다루는 프로젝트입니다. (DEVELOPER)', 'https://images.port.kr/project/26.png', 'React, TypeScript, Spring Boot', FALSE, '2022-01-01', '2022-12-31', 2),



(27, 14, '회고 기록 시스템 27', 'DEVELOPER', '상태와 결과가 한눈에 보이도록 정리한 프로젝트입니다. (DEVELOPER)', 'https://images.port.kr/project/27.png', 'React, TypeScript, Spring Boot', TRUE, '2023-01-01', '2023-12-31', 1),



(28, 14, '모바일 앱 개발 28', 'PM', '실제 운영 화면과 문서 흐름을 함께 정리한 프로젝트입니다. (PM)', 'https://images.port.kr/project/28.png', 'Notion, Figma, Roadmap', FALSE, '2020-01-01', '2020-12-31', 2),



(29, 15, '콘텐트 구조 전환 29', 'PM', '요구사항, 호스팅, 설계를 구조적으로 다루는 프로젝트입니다. (PM)', 'https://images.port.kr/project/29.png', 'Notion, Figma, Roadmap', TRUE, '2021-01-01', '2021-12-31', 1),



(30, 15, '집중도 개선 30', 'DEVELOPER', '상태와 결과가 한눈에 보이도록 정리한 프로젝트입니다. (DEVELOPER)', 'https://images.port.kr/project/30.png', 'React, TypeScript, Spring Boot', FALSE, '2022-01-01', '2022-12-31', 2),



(31, 16, '이커머스 플랫폼 리뉴얼 31', 'DEVELOPER', '실제 운영 화면과 문서 흐름을 함께 정리한 프로젝트입니다. (DEVELOPER)', 'https://images.port.kr/project/31.png', 'React, TypeScript, Spring Boot', TRUE, '2023-01-01', '2023-12-31', 1),



(32, 16, '사용자 프로필 길들이기 32', 'PM', '요구사항, 호스팅, 설계를 구조적으로 다루는 프로젝트입니다. (PM)', 'https://images.port.kr/project/32.png', 'Notion, Figma, Roadmap', FALSE, '2020-01-01', '2020-12-31', 2),



(33, 17, '문서 협업 개선 33', 'PM', '상태와 결과가 한눈에 보이도록 정리한 프로젝트입니다. (PM)', 'https://images.port.kr/project/33.png', 'Notion, Figma, Roadmap', TRUE, '2021-01-01', '2021-12-31', 1),



(34, 17, '어드민스 대시보드 34', 'DEVELOPER', '실제 운영 화면과 문서 흐름을 함께 정리한 프로젝트입니다. (DEVELOPER)', 'https://images.port.kr/project/34.png', 'React, TypeScript, Spring Boot', FALSE, '2022-01-01', '2022-12-31', 2),



(35, 18, '플랜너 설계 35', 'DEVELOPER', '요구사항, 호스팅, 설계를 구조적으로 다루는 프로젝트입니다. (DEVELOPER)', 'https://images.port.kr/project/35.png', 'React, TypeScript, Spring Boot', TRUE, '2023-01-01', '2023-12-31', 1),



(36, 18, '기술 구조 정리 36', 'PM', '상태와 결과가 한눈에 보이도록 정리한 프로젝트입니다. (PM)', 'https://images.port.kr/project/36.png', 'Notion, Figma, Roadmap', FALSE, '2020-01-01', '2020-12-31', 2),



(37, 19, '회고 기록 시스템 37', 'PM', '실제 운영 화면과 문서 흐름을 함께 정리한 프로젝트입니다. (PM)', 'https://images.port.kr/project/37.png', 'Notion, Figma, Roadmap', TRUE, '2021-01-01', '2021-12-31', 1),



(38, 19, '모바일 앱 개발 38', 'DEVELOPER', '요구사항, 호스팅, 설계를 구조적으로 다루는 프로젝트입니다. (DEVELOPER)', 'https://images.port.kr/project/38.png', 'React, TypeScript, Spring Boot', FALSE, '2022-01-01', '2022-12-31', 2),



(39, 20, '콘텐트 구조 전환 39', 'DEVELOPER', '상태와 결과가 한눈에 보이도록 정리한 프로젝트입니다. (DEVELOPER)', 'https://images.port.kr/project/39.png', 'React, TypeScript, Spring Boot', TRUE, '2023-01-01', '2023-12-31', 1),



(40, 20, '집중도 개선 40', 'PM', '실제 운영 화면과 문서 흐름을 함께 정리한 프로젝트입니다. (PM)', 'https://images.port.kr/project/40.png', 'Notion, Figma, Roadmap', FALSE, '2020-01-01', '2020-12-31', 2);



INSERT INTO projects (id, portfolio_id, name, role, summary, thumbnail_url, skills, is_synced, start_date, end_date, order_index) VALUES



(41, 21, '이커머스 플랫폼 리뉴얼 41', 'PM', '요구사항, 호스팅, 설계를 구조적으로 다루는 프로젝트입니다. (PM)', 'https://images.port.kr/project/41.png', 'Notion, Figma, Roadmap', TRUE, '2021-01-01', '2021-12-31', 1),



(42, 21, '사용자 프로필 길들이기 42', 'DEVELOPER', '상태와 결과가 한눈에 보이도록 정리한 프로젝트입니다. (DEVELOPER)', 'https://images.port.kr/project/42.png', 'React, TypeScript, Spring Boot', FALSE, '2022-01-01', '2022-12-31', 2),



(43, 22, '문서 협업 개선 43', 'DEVELOPER', '실제 운영 화면과 문서 흐름을 함께 정리한 프로젝트입니다. (DEVELOPER)', 'https://images.port.kr/project/43.png', 'React, TypeScript, Spring Boot', TRUE, '2023-01-01', '2023-12-31', 1),



(44, 22, '어드민스 대시보드 44', 'PM', '요구사항, 호스팅, 설계를 구조적으로 다루는 프로젝트입니다. (PM)', 'https://images.port.kr/project/44.png', 'Notion, Figma, Roadmap', FALSE, '2020-01-01', '2020-12-31', 2),



(45, 23, '플랜너 설계 45', 'PM', '상태와 결과가 한눈에 보이도록 정리한 프로젝트입니다. (PM)', 'https://images.port.kr/project/45.png', 'Notion, Figma, Roadmap', TRUE, '2021-01-01', '2021-12-31', 1),



(46, 23, '기술 구조 정리 46', 'DEVELOPER', '실제 운영 화면과 문서 흐름을 함께 정리한 프로젝트입니다. (DEVELOPER)', 'https://images.port.kr/project/46.png', 'React, TypeScript, Spring Boot', FALSE, '2022-01-01', '2022-12-31', 2),



(47, 24, '회고 기록 시스템 47', 'DEVELOPER', '요구사항, 호스팅, 설계를 구조적으로 다루는 프로젝트입니다. (DEVELOPER)', 'https://images.port.kr/project/47.png', 'React, TypeScript, Spring Boot', TRUE, '2023-01-01', '2023-12-31', 1),



(48, 24, '모바일 앱 개발 48', 'PM', '상태와 결과가 한눈에 보이도록 정리한 프로젝트입니다. (PM)', 'https://images.port.kr/project/48.png', 'Notion, Figma, Roadmap', FALSE, '2020-01-01', '2020-12-31', 2),



(49, 25, '콘텐트 구조 전환 49', 'PM', '실제 운영 화면과 문서 흐름을 함께 정리한 프로젝트입니다. (PM)', 'https://images.port.kr/project/49.png', 'Notion, Figma, Roadmap', TRUE, '2021-01-01', '2021-12-31', 1),



(50, 25, '집중도 개선 50', 'DEVELOPER', '요구사항, 호스팅, 설계를 구조적으로 다루는 프로젝트입니다. (DEVELOPER)', 'https://images.port.kr/project/50.png', 'React, TypeScript, Spring Boot', FALSE, '2022-01-01', '2022-12-31', 2),



(51, 26, '이커머스 플랫폼 리뉴얼 51', 'DEVELOPER', '상태와 결과가 한눈에 보이도록 정리한 프로젝트입니다. (DEVELOPER)', 'https://images.port.kr/project/51.png', 'React, TypeScript, Spring Boot', TRUE, '2023-01-01', '2023-12-31', 1),



(52, 26, '사용자 프로필 길들이기 52', 'PM', '실제 운영 화면과 문서 흐름을 함께 정리한 프로젝트입니다. (PM)', 'https://images.port.kr/project/52.png', 'Notion, Figma, Roadmap', FALSE, '2020-01-01', '2020-12-31', 2),



(53, 27, '문서 협업 개선 53', 'PM', '요구사항, 호스팅, 설계를 구조적으로 다루는 프로젝트입니다. (PM)', 'https://images.port.kr/project/53.png', 'Notion, Figma, Roadmap', TRUE, '2021-01-01', '2021-12-31', 1),



(54, 27, '어드민스 대시보드 54', 'DEVELOPER', '상태와 결과가 한눈에 보이도록 정리한 프로젝트입니다. (DEVELOPER)', 'https://images.port.kr/project/54.png', 'React, TypeScript, Spring Boot', FALSE, '2022-01-01', '2022-12-31', 2),



(55, 28, '플랜너 설계 55', 'DEVELOPER', '실제 운영 화면과 문서 흐름을 함께 정리한 프로젝트입니다. (DEVELOPER)', 'https://images.port.kr/project/55.png', 'React, TypeScript, Spring Boot', TRUE, '2023-01-01', '2023-12-31', 1),



(56, 28, '기술 구조 정리 56', 'PM', '요구사항, 호스팅, 설계를 구조적으로 다루는 프로젝트입니다. (PM)', 'https://images.port.kr/project/56.png', 'Notion, Figma, Roadmap', FALSE, '2020-01-01', '2020-12-31', 2),



(57, 29, '회고 기록 시스템 57', 'PM', '상태와 결과가 한눈에 보이도록 정리한 프로젝트입니다. (PM)', 'https://images.port.kr/project/57.png', 'Notion, Figma, Roadmap', TRUE, '2021-01-01', '2021-12-31', 1),



(58, 29, '모바일 앱 개발 58', 'DEVELOPER', '실제 운영 화면과 문서 흐름을 함께 정리한 프로젝트입니다. (DEVELOPER)', 'https://images.port.kr/project/58.png', 'React, TypeScript, Spring Boot', FALSE, '2022-01-01', '2022-12-31', 2),



(59, 30, '콘텐트 구조 전환 59', 'DEVELOPER', '요구사항, 호스팅, 설계를 구조적으로 다루는 프로젝트입니다. (DEVELOPER)', 'https://images.port.kr/project/59.png', 'React, TypeScript, Spring Boot', TRUE, '2023-01-01', '2023-12-31', 1),



(60, 30, '집중도 개선 60', 'PM', '상태와 결과가 한눈에 보이도록 정리한 프로젝트입니다. (PM)', 'https://images.port.kr/project/60.png', 'Notion, Figma, Roadmap', FALSE, '2020-01-01', '2020-12-31', 2),



(61, 31, '이커머스 플랫폼 리뉴얼 61', 'PM', '실제 운영 화면과 문서 흐름을 함께 정리한 프로젝트입니다. (PM)', 'https://images.port.kr/project/61.png', 'Notion, Figma, Roadmap', TRUE, '2021-01-01', '2021-12-31', 1),



(62, 31, '사용자 프로필 길들이기 62', 'DEVELOPER', '요구사항, 호스팅, 설계를 구조적으로 다루는 프로젝트입니다. (DEVELOPER)', 'https://images.port.kr/project/62.png', 'React, TypeScript, Spring Boot', FALSE, '2022-01-01', '2022-12-31', 2),



(63, 32, '문서 협업 개선 63', 'DEVELOPER', '상태와 결과가 한눈에 보이도록 정리한 프로젝트입니다. (DEVELOPER)', 'https://images.port.kr/project/63.png', 'React, TypeScript, Spring Boot', TRUE, '2023-01-01', '2023-12-31', 1),



(64, 32, '어드민스 대시보드 64', 'PM', '실제 운영 화면과 문서 흐름을 함께 정리한 프로젝트입니다. (PM)', 'https://images.port.kr/project/64.png', 'Notion, Figma, Roadmap', FALSE, '2020-01-01', '2020-12-31', 2),



(65, 33, '플랜너 설계 65', 'PM', '요구사항, 호스팅, 설계를 구조적으로 다루는 프로젝트입니다. (PM)', 'https://images.port.kr/project/65.png', 'Notion, Figma, Roadmap', TRUE, '2021-01-01', '2021-12-31', 1),



(66, 33, '기술 구조 정리 66', 'DEVELOPER', '상태와 결과가 한눈에 보이도록 정리한 프로젝트입니다. (DEVELOPER)', 'https://images.port.kr/project/66.png', 'React, TypeScript, Spring Boot', FALSE, '2022-01-01', '2022-12-31', 2),



(67, 34, '회고 기록 시스템 67', 'DEVELOPER', '실제 운영 화면과 문서 흐름을 함께 정리한 프로젝트입니다. (DEVELOPER)', 'https://images.port.kr/project/67.png', 'React, TypeScript, Spring Boot', TRUE, '2023-01-01', '2023-12-31', 1),



(68, 34, '모바일 앱 개발 68', 'PM', '요구사항, 호스팅, 설계를 구조적으로 다루는 프로젝트입니다. (PM)', 'https://images.port.kr/project/68.png', 'Notion, Figma, Roadmap', FALSE, '2020-01-01', '2020-12-31', 2),



(69, 35, '콘텐트 구조 전환 69', 'PM', '상태와 결과가 한눈에 보이도록 정리한 프로젝트입니다. (PM)', 'https://images.port.kr/project/69.png', 'Notion, Figma, Roadmap', TRUE, '2021-01-01', '2021-12-31', 1),



(70, 35, '집중도 개선 70', 'DEVELOPER', '실제 운영 화면과 문서 흐름을 함께 정리한 프로젝트입니다. (DEVELOPER)', 'https://images.port.kr/project/70.png', 'React, TypeScript, Spring Boot', FALSE, '2022-01-01', '2022-12-31', 2),



(71, 36, '이커머스 플랫폼 리뉴얼 71', 'DEVELOPER', '요구사항, 호스팅, 설계를 구조적으로 다루는 프로젝트입니다. (DEVELOPER)', 'https://images.port.kr/project/71.png', 'React, TypeScript, Spring Boot', TRUE, '2023-01-01', '2023-12-31', 1),



(72, 36, '사용자 프로필 길들이기 72', 'PM', '상태와 결과가 한눈에 보이도록 정리한 프로젝트입니다. (PM)', 'https://images.port.kr/project/72.png', 'Notion, Figma, Roadmap', FALSE, '2020-01-01', '2020-12-31', 2),



(73, 37, '문서 협업 개선 73', 'PM', '실제 운영 화면과 문서 흐름을 함께 정리한 프로젝트입니다. (PM)', 'https://images.port.kr/project/73.png', 'Notion, Figma, Roadmap', TRUE, '2021-01-01', '2021-12-31', 1),



(74, 37, '어드민스 대시보드 74', 'DEVELOPER', '요구사항, 호스팅, 설계를 구조적으로 다루는 프로젝트입니다. (DEVELOPER)', 'https://images.port.kr/project/74.png', 'React, TypeScript, Spring Boot', FALSE, '2022-01-01', '2022-12-31', 2),



(75, 38, '플랜너 설계 75', 'DEVELOPER', '상태와 결과가 한눈에 보이도록 정리한 프로젝트입니다. (DEVELOPER)', 'https://images.port.kr/project/75.png', 'React, TypeScript, Spring Boot', TRUE, '2023-01-01', '2023-12-31', 1),



(76, 38, '기술 구조 정리 76', 'PM', '실제 운영 화면과 문서 흐름을 함께 정리한 프로젝트입니다. (PM)', 'https://images.port.kr/project/76.png', 'Notion, Figma, Roadmap', FALSE, '2020-01-01', '2020-12-31', 2),



(77, 39, '회고 기록 시스템 77', 'PM', '요구사항, 호스팅, 설계를 구조적으로 다루는 프로젝트입니다. (PM)', 'https://images.port.kr/project/77.png', 'Notion, Figma, Roadmap', TRUE, '2021-01-01', '2021-12-31', 1),



(78, 39, '모바일 앱 개발 78', 'DEVELOPER', '상태와 결과가 한눈에 보이도록 정리한 프로젝트입니다. (DEVELOPER)', 'https://images.port.kr/project/78.png', 'React, TypeScript, Spring Boot', FALSE, '2022-01-01', '2022-12-31', 2),



(79, 40, '콘텐트 구조 전환 79', 'DEVELOPER', '실제 운영 화면과 문서 흐름을 함께 정리한 프로젝트입니다. (DEVELOPER)', 'https://images.port.kr/project/79.png', 'React, TypeScript, Spring Boot', TRUE, '2023-01-01', '2023-12-31', 1),



(80, 40, '집중도 개선 80', 'PM', '요구사항, 호스팅, 설계를 구조적으로 다루는 프로젝트입니다. (PM)', 'https://images.port.kr/project/80.png', 'Notion, Figma, Roadmap', FALSE, '2020-01-01', '2020-12-31', 2);



INSERT INTO projects (id, portfolio_id, name, role, summary, thumbnail_url, skills, is_synced, start_date, end_date, order_index) VALUES



(81, 41, '이커머스 플랫폼 리뉴얼 81', 'PM', '상태와 결과가 한눈에 보이도록 정리한 프로젝트입니다. (PM)', 'https://images.port.kr/project/81.png', 'Notion, Figma, Roadmap', TRUE, '2021-01-01', '2021-12-31', 1),



(82, 41, '사용자 프로필 길들이기 82', 'DEVELOPER', '실제 운영 화면과 문서 흐름을 함께 정리한 프로젝트입니다. (DEVELOPER)', 'https://images.port.kr/project/82.png', 'React, TypeScript, Spring Boot', FALSE, '2022-01-01', '2022-12-31', 2),



(83, 42, '문서 협업 개선 83', 'DEVELOPER', '요구사항, 호스팅, 설계를 구조적으로 다루는 프로젝트입니다. (DEVELOPER)', 'https://images.port.kr/project/83.png', 'React, TypeScript, Spring Boot', TRUE, '2023-01-01', '2023-12-31', 1),



(84, 42, '어드민스 대시보드 84', 'PM', '상태와 결과가 한눈에 보이도록 정리한 프로젝트입니다. (PM)', 'https://images.port.kr/project/84.png', 'Notion, Figma, Roadmap', FALSE, '2020-01-01', '2020-12-31', 2),



(85, 43, '플랜너 설계 85', 'PM', '실제 운영 화면과 문서 흐름을 함께 정리한 프로젝트입니다. (PM)', 'https://images.port.kr/project/85.png', 'Notion, Figma, Roadmap', TRUE, '2021-01-01', '2021-12-31', 1),



(86, 43, '기술 구조 정리 86', 'DEVELOPER', '요구사항, 호스팅, 설계를 구조적으로 다루는 프로젝트입니다. (DEVELOPER)', 'https://images.port.kr/project/86.png', 'React, TypeScript, Spring Boot', FALSE, '2022-01-01', '2022-12-31', 2),



(87, 44, '회고 기록 시스템 87', 'DEVELOPER', '상태와 결과가 한눈에 보이도록 정리한 프로젝트입니다. (DEVELOPER)', 'https://images.port.kr/project/87.png', 'React, TypeScript, Spring Boot', TRUE, '2023-01-01', '2023-12-31', 1),



(88, 44, '모바일 앱 개발 88', 'PM', '실제 운영 화면과 문서 흐름을 함께 정리한 프로젝트입니다. (PM)', 'https://images.port.kr/project/88.png', 'Notion, Figma, Roadmap', FALSE, '2020-01-01', '2020-12-31', 2),



(89, 45, '콘텐트 구조 전환 89', 'PM', '요구사항, 호스팅, 설계를 구조적으로 다루는 프로젝트입니다. (PM)', 'https://images.port.kr/project/89.png', 'Notion, Figma, Roadmap', TRUE, '2021-01-01', '2021-12-31', 1),



(90, 45, '집중도 개선 90', 'DEVELOPER', '상태와 결과가 한눈에 보이도록 정리한 프로젝트입니다. (DEVELOPER)', 'https://images.port.kr/project/90.png', 'React, TypeScript, Spring Boot', FALSE, '2022-01-01', '2022-12-31', 2),



(91, 46, '이커머스 플랫폼 리뉴얼 91', 'DEVELOPER', '실제 운영 화면과 문서 흐름을 함께 정리한 프로젝트입니다. (DEVELOPER)', 'https://images.port.kr/project/91.png', 'React, TypeScript, Spring Boot', TRUE, '2023-01-01', '2023-12-31', 1),



(92, 46, '사용자 프로필 길들이기 92', 'PM', '요구사항, 호스팅, 설계를 구조적으로 다루는 프로젝트입니다. (PM)', 'https://images.port.kr/project/92.png', 'Notion, Figma, Roadmap', FALSE, '2020-01-01', '2020-12-31', 2),



(93, 47, '문서 협업 개선 93', 'PM', '상태와 결과가 한눈에 보이도록 정리한 프로젝트입니다. (PM)', 'https://images.port.kr/project/93.png', 'Notion, Figma, Roadmap', TRUE, '2021-01-01', '2021-12-31', 1),



(94, 47, '어드민스 대시보드 94', 'DEVELOPER', '실제 운영 화면과 문서 흐름을 함께 정리한 프로젝트입니다. (DEVELOPER)', 'https://images.port.kr/project/94.png', 'React, TypeScript, Spring Boot', FALSE, '2022-01-01', '2022-12-31', 2),



(95, 48, '플랜너 설계 95', 'DEVELOPER', '요구사항, 호스팅, 설계를 구조적으로 다루는 프로젝트입니다. (DEVELOPER)', 'https://images.port.kr/project/95.png', 'React, TypeScript, Spring Boot', TRUE, '2023-01-01', '2023-12-31', 1),



(96, 48, '기술 구조 정리 96', 'PM', '상태와 결과가 한눈에 보이도록 정리한 프로젝트입니다. (PM)', 'https://images.port.kr/project/96.png', 'Notion, Figma, Roadmap', FALSE, '2020-01-01', '2020-12-31', 2),



(97, 49, '회고 기록 시스템 97', 'PM', '실제 운영 화면과 문서 흐름을 함께 정리한 프로젝트입니다. (PM)', 'https://images.port.kr/project/97.png', 'Notion, Figma, Roadmap', TRUE, '2021-01-01', '2021-12-31', 1),



(98, 49, '모바일 앱 개발 98', 'DEVELOPER', '요구사항, 호스팅, 설계를 구조적으로 다루는 프로젝트입니다. (DEVELOPER)', 'https://images.port.kr/project/98.png', 'React, TypeScript, Spring Boot', FALSE, '2022-01-01', '2022-12-31', 2),



(99, 50, '콘텐트 구조 전환 99', 'DEVELOPER', '상태와 결과가 한눈에 보이도록 정리한 프로젝트입니다. (DEVELOPER)', 'https://images.port.kr/project/99.png', 'React, TypeScript, Spring Boot', TRUE, '2023-01-01', '2023-12-31', 1),



(100, 50, '집중도 개선 100', 'PM', '실제 운영 화면과 문서 흐름을 함께 정리한 프로젝트입니다. (PM)', 'https://images.port.kr/project/100.png', 'Notion, Figma, Roadmap', FALSE, '2020-01-01', '2020-12-31', 2);



INSERT INTO project_writing_sessions (id, project_id, status, role, progress, selected_sources_json, source_snapshot_json, section_draft_json, section_status_json, document_text, reviewed_document, presentation_json, last_error, last_saved_at) VALUES



(1, 1, 'WRITING', 'PM', 7, '{"provider": "GITHUB", "sourceIds": ["repo-1", "page-1"]}', '{"snapshot": "snapshot-1"}', '{"overview": "Draft for project 1"}', '{"overview": "COMPLETED"}', 'Project document 1', 'Reviewed document 1', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-02 10:00:00'),



(2, 2, 'DOCUMENT_CREATED', 'DEVELOPER', 14, '{"provider": "GITHUB", "sourceIds": ["repo-2", "page-2"]}', '{"snapshot": "snapshot-2"}', '{"overview": "Draft for project 2"}', '{"overview": "COMPLETED"}', 'Project document 2', 'Reviewed document 2', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-03 10:00:00'),



(3, 3, 'REVIEWED', 'DEVELOPER', 21, '{"provider": "GITHUB", "sourceIds": ["repo-3", "page-3"]}', '{"snapshot": "snapshot-3"}', '{"overview": "Draft for project 3"}', '{"overview": "COMPLETED"}', 'Project document 3', 'Reviewed document 3', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-04 10:00:00'),



(4, 4, 'PPT_CREATED', 'PM', 28, '{"provider": "GITHUB", "sourceIds": ["repo-4", "page-4"]}', '{"snapshot": "snapshot-4"}', '{"overview": "Draft for project 4"}', '{"overview": "COMPLETED"}', 'Project document 4', 'Reviewed document 4', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-05 10:00:00'),



(5, 5, 'NOT_STARTED', 'PM', 35, '{"provider": "GITHUB", "sourceIds": ["repo-5", "page-5"]}', '{"snapshot": "snapshot-5"}', '{"overview": "Draft for project 5"}', '{"overview": "COMPLETED"}', 'Project document 5', 'Reviewed document 5', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-06 10:00:00'),



(6, 6, 'WRITING', 'DEVELOPER', 42, '{"provider": "GITHUB", "sourceIds": ["repo-6", "page-6"]}', '{"snapshot": "snapshot-6"}', '{"overview": "Draft for project 6"}', '{"overview": "COMPLETED"}', 'Project document 6', 'Reviewed document 6', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-07 10:00:00'),



(7, 7, 'DOCUMENT_CREATED', 'DEVELOPER', 49, '{"provider": "GITHUB", "sourceIds": ["repo-7", "page-7"]}', '{"snapshot": "snapshot-7"}', '{"overview": "Draft for project 7"}', '{"overview": "COMPLETED"}', 'Project document 7', 'Reviewed document 7', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-08 10:00:00'),



(8, 8, 'REVIEWED', 'PM', 56, '{"provider": "GITHUB", "sourceIds": ["repo-8", "page-8"]}', '{"snapshot": "snapshot-8"}', '{"overview": "Draft for project 8"}', '{"overview": "COMPLETED"}', 'Project document 8', 'Reviewed document 8', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-09 10:00:00'),



(9, 9, 'PPT_CREATED', 'PM', 63, '{"provider": "GITHUB", "sourceIds": ["repo-9", "page-9"]}', '{"snapshot": "snapshot-9"}', '{"overview": "Draft for project 9"}', '{"overview": "COMPLETED"}', 'Project document 9', 'Reviewed document 9', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-10 10:00:00'),



(10, 10, 'NOT_STARTED', 'DEVELOPER', 70, '{"provider": "GITHUB", "sourceIds": ["repo-10", "page-10"]}', '{"snapshot": "snapshot-10"}', '{"overview": "Draft for project 10"}', '{"overview": "COMPLETED"}', 'Project document 10', 'Reviewed document 10', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-11 10:00:00'),



(11, 11, 'WRITING', 'DEVELOPER', 77, '{"provider": "GITHUB", "sourceIds": ["repo-11", "page-11"]}', '{"snapshot": "snapshot-11"}', '{"overview": "Draft for project 11"}', '{"overview": "COMPLETED"}', 'Project document 11', 'Reviewed document 11', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-12 10:00:00'),



(12, 12, 'DOCUMENT_CREATED', 'PM', 84, '{"provider": "GITHUB", "sourceIds": ["repo-12", "page-12"]}', '{"snapshot": "snapshot-12"}', '{"overview": "Draft for project 12"}', '{"overview": "COMPLETED"}', 'Project document 12', 'Reviewed document 12', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-13 10:00:00'),



(13, 13, 'REVIEWED', 'PM', 91, '{"provider": "GITHUB", "sourceIds": ["repo-13", "page-13"]}', '{"snapshot": "snapshot-13"}', '{"overview": "Draft for project 13"}', '{"overview": "COMPLETED"}', 'Project document 13', 'Reviewed document 13', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-14 10:00:00'),



(14, 14, 'PPT_CREATED', 'DEVELOPER', 98, '{"provider": "GITHUB", "sourceIds": ["repo-14", "page-14"]}', '{"snapshot": "snapshot-14"}', '{"overview": "Draft for project 14"}', '{"overview": "COMPLETED"}', 'Project document 14', 'Reviewed document 14', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-15 10:00:00'),



(15, 15, 'NOT_STARTED', 'DEVELOPER', 5, '{"provider": "GITHUB", "sourceIds": ["repo-15", "page-15"]}', '{"snapshot": "snapshot-15"}', '{"overview": "Draft for project 15"}', '{"overview": "COMPLETED"}', 'Project document 15', 'Reviewed document 15', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-16 10:00:00'),



(16, 16, 'WRITING', 'PM', 12, '{"provider": "GITHUB", "sourceIds": ["repo-16", "page-16"]}', '{"snapshot": "snapshot-16"}', '{"overview": "Draft for project 16"}', '{"overview": "COMPLETED"}', 'Project document 16', 'Reviewed document 16', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-17 10:00:00'),



(17, 17, 'DOCUMENT_CREATED', 'PM', 19, '{"provider": "GITHUB", "sourceIds": ["repo-17", "page-17"]}', '{"snapshot": "snapshot-17"}', '{"overview": "Draft for project 17"}', '{"overview": "COMPLETED"}', 'Project document 17', 'Reviewed document 17', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-18 10:00:00'),



(18, 18, 'REVIEWED', 'DEVELOPER', 26, '{"provider": "GITHUB", "sourceIds": ["repo-18", "page-18"]}', '{"snapshot": "snapshot-18"}', '{"overview": "Draft for project 18"}', '{"overview": "COMPLETED"}', 'Project document 18', 'Reviewed document 18', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-19 10:00:00'),



(19, 19, 'PPT_CREATED', 'DEVELOPER', 33, '{"provider": "GITHUB", "sourceIds": ["repo-19", "page-19"]}', '{"snapshot": "snapshot-19"}', '{"overview": "Draft for project 19"}', '{"overview": "COMPLETED"}', 'Project document 19', 'Reviewed document 19', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-20 10:00:00'),



(20, 20, 'NOT_STARTED', 'PM', 40, '{"provider": "GITHUB", "sourceIds": ["repo-20", "page-20"]}', '{"snapshot": "snapshot-20"}', '{"overview": "Draft for project 20"}', '{"overview": "COMPLETED"}', 'Project document 20', 'Reviewed document 20', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-21 10:00:00'),



(21, 21, 'WRITING', 'PM', 47, '{"provider": "GITHUB", "sourceIds": ["repo-21", "page-21"]}', '{"snapshot": "snapshot-21"}', '{"overview": "Draft for project 21"}', '{"overview": "COMPLETED"}', 'Project document 21', 'Reviewed document 21', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-22 10:00:00'),



(22, 22, 'DOCUMENT_CREATED', 'DEVELOPER', 54, '{"provider": "GITHUB", "sourceIds": ["repo-22", "page-22"]}', '{"snapshot": "snapshot-22"}', '{"overview": "Draft for project 22"}', '{"overview": "COMPLETED"}', 'Project document 22', 'Reviewed document 22', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-23 10:00:00'),



(23, 23, 'REVIEWED', 'DEVELOPER', 61, '{"provider": "GITHUB", "sourceIds": ["repo-23", "page-23"]}', '{"snapshot": "snapshot-23"}', '{"overview": "Draft for project 23"}', '{"overview": "COMPLETED"}', 'Project document 23', 'Reviewed document 23', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-24 10:00:00'),



(24, 24, 'PPT_CREATED', 'PM', 68, '{"provider": "GITHUB", "sourceIds": ["repo-24", "page-24"]}', '{"snapshot": "snapshot-24"}', '{"overview": "Draft for project 24"}', '{"overview": "COMPLETED"}', 'Project document 24', 'Reviewed document 24', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-25 10:00:00'),



(25, 25, 'NOT_STARTED', 'PM', 75, '{"provider": "GITHUB", "sourceIds": ["repo-25", "page-25"]}', '{"snapshot": "snapshot-25"}', '{"overview": "Draft for project 25"}', '{"overview": "COMPLETED"}', 'Project document 25', 'Reviewed document 25', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-26 10:00:00'),



(26, 26, 'WRITING', 'DEVELOPER', 82, '{"provider": "GITHUB", "sourceIds": ["repo-26", "page-26"]}', '{"snapshot": "snapshot-26"}', '{"overview": "Draft for project 26"}', '{"overview": "COMPLETED"}', 'Project document 26', 'Reviewed document 26', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-27 10:00:00'),



(27, 27, 'DOCUMENT_CREATED', 'DEVELOPER', 89, '{"provider": "GITHUB", "sourceIds": ["repo-27", "page-27"]}', '{"snapshot": "snapshot-27"}', '{"overview": "Draft for project 27"}', '{"overview": "COMPLETED"}', 'Project document 27', 'Reviewed document 27', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-28 10:00:00'),



(28, 28, 'REVIEWED', 'PM', 96, '{"provider": "GITHUB", "sourceIds": ["repo-28", "page-28"]}', '{"snapshot": "snapshot-28"}', '{"overview": "Draft for project 28"}', '{"overview": "COMPLETED"}', 'Project document 28', 'Reviewed document 28', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-01 10:00:00'),



(29, 29, 'PPT_CREATED', 'PM', 3, '{"provider": "GITHUB", "sourceIds": ["repo-29", "page-29"]}', '{"snapshot": "snapshot-29"}', '{"overview": "Draft for project 29"}', '{"overview": "COMPLETED"}', 'Project document 29', 'Reviewed document 29', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-02 10:00:00'),



(30, 30, 'NOT_STARTED', 'DEVELOPER', 10, '{"provider": "GITHUB", "sourceIds": ["repo-30", "page-30"]}', '{"snapshot": "snapshot-30"}', '{"overview": "Draft for project 30"}', '{"overview": "COMPLETED"}', 'Project document 30', 'Reviewed document 30', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-03 10:00:00'),



(31, 31, 'WRITING', 'DEVELOPER', 17, '{"provider": "GITHUB", "sourceIds": ["repo-31", "page-31"]}', '{"snapshot": "snapshot-31"}', '{"overview": "Draft for project 31"}', '{"overview": "COMPLETED"}', 'Project document 31', 'Reviewed document 31', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-04 10:00:00'),



(32, 32, 'DOCUMENT_CREATED', 'PM', 24, '{"provider": "GITHUB", "sourceIds": ["repo-32", "page-32"]}', '{"snapshot": "snapshot-32"}', '{"overview": "Draft for project 32"}', '{"overview": "COMPLETED"}', 'Project document 32', 'Reviewed document 32', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-05 10:00:00'),



(33, 33, 'REVIEWED', 'PM', 31, '{"provider": "GITHUB", "sourceIds": ["repo-33", "page-33"]}', '{"snapshot": "snapshot-33"}', '{"overview": "Draft for project 33"}', '{"overview": "COMPLETED"}', 'Project document 33', 'Reviewed document 33', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-06 10:00:00'),



(34, 34, 'PPT_CREATED', 'DEVELOPER', 38, '{"provider": "GITHUB", "sourceIds": ["repo-34", "page-34"]}', '{"snapshot": "snapshot-34"}', '{"overview": "Draft for project 34"}', '{"overview": "COMPLETED"}', 'Project document 34', 'Reviewed document 34', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-07 10:00:00'),



(35, 35, 'NOT_STARTED', 'DEVELOPER', 45, '{"provider": "GITHUB", "sourceIds": ["repo-35", "page-35"]}', '{"snapshot": "snapshot-35"}', '{"overview": "Draft for project 35"}', '{"overview": "COMPLETED"}', 'Project document 35', 'Reviewed document 35', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-08 10:00:00'),



(36, 36, 'WRITING', 'PM', 52, '{"provider": "GITHUB", "sourceIds": ["repo-36", "page-36"]}', '{"snapshot": "snapshot-36"}', '{"overview": "Draft for project 36"}', '{"overview": "COMPLETED"}', 'Project document 36', 'Reviewed document 36', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-09 10:00:00'),



(37, 37, 'DOCUMENT_CREATED', 'PM', 59, '{"provider": "GITHUB", "sourceIds": ["repo-37", "page-37"]}', '{"snapshot": "snapshot-37"}', '{"overview": "Draft for project 37"}', '{"overview": "COMPLETED"}', 'Project document 37', 'Reviewed document 37', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-10 10:00:00'),



(38, 38, 'REVIEWED', 'DEVELOPER', 66, '{"provider": "GITHUB", "sourceIds": ["repo-38", "page-38"]}', '{"snapshot": "snapshot-38"}', '{"overview": "Draft for project 38"}', '{"overview": "COMPLETED"}', 'Project document 38', 'Reviewed document 38', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-11 10:00:00'),



(39, 39, 'PPT_CREATED', 'DEVELOPER', 73, '{"provider": "GITHUB", "sourceIds": ["repo-39", "page-39"]}', '{"snapshot": "snapshot-39"}', '{"overview": "Draft for project 39"}', '{"overview": "COMPLETED"}', 'Project document 39', 'Reviewed document 39', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-12 10:00:00'),



(40, 40, 'NOT_STARTED', 'PM', 80, '{"provider": "GITHUB", "sourceIds": ["repo-40", "page-40"]}', '{"snapshot": "snapshot-40"}', '{"overview": "Draft for project 40"}', '{"overview": "COMPLETED"}', 'Project document 40', 'Reviewed document 40', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-13 10:00:00');



INSERT INTO project_writing_sessions (id, project_id, status, role, progress, selected_sources_json, source_snapshot_json, section_draft_json, section_status_json, document_text, reviewed_document, presentation_json, last_error, last_saved_at) VALUES



(41, 41, 'WRITING', 'PM', 87, '{"provider": "GITHUB", "sourceIds": ["repo-41", "page-41"]}', '{"snapshot": "snapshot-41"}', '{"overview": "Draft for project 41"}', '{"overview": "COMPLETED"}', 'Project document 41', 'Reviewed document 41', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-14 10:00:00'),



(42, 42, 'DOCUMENT_CREATED', 'DEVELOPER', 94, '{"provider": "GITHUB", "sourceIds": ["repo-42", "page-42"]}', '{"snapshot": "snapshot-42"}', '{"overview": "Draft for project 42"}', '{"overview": "COMPLETED"}', 'Project document 42', 'Reviewed document 42', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-15 10:00:00'),



(43, 43, 'REVIEWED', 'DEVELOPER', 1, '{"provider": "GITHUB", "sourceIds": ["repo-43", "page-43"]}', '{"snapshot": "snapshot-43"}', '{"overview": "Draft for project 43"}', '{"overview": "COMPLETED"}', 'Project document 43', 'Reviewed document 43', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-16 10:00:00'),



(44, 44, 'PPT_CREATED', 'PM', 8, '{"provider": "GITHUB", "sourceIds": ["repo-44", "page-44"]}', '{"snapshot": "snapshot-44"}', '{"overview": "Draft for project 44"}', '{"overview": "COMPLETED"}', 'Project document 44', 'Reviewed document 44', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-17 10:00:00'),



(45, 45, 'NOT_STARTED', 'PM', 15, '{"provider": "GITHUB", "sourceIds": ["repo-45", "page-45"]}', '{"snapshot": "snapshot-45"}', '{"overview": "Draft for project 45"}', '{"overview": "COMPLETED"}', 'Project document 45', 'Reviewed document 45', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-18 10:00:00'),



(46, 46, 'WRITING', 'DEVELOPER', 22, '{"provider": "GITHUB", "sourceIds": ["repo-46", "page-46"]}', '{"snapshot": "snapshot-46"}', '{"overview": "Draft for project 46"}', '{"overview": "COMPLETED"}', 'Project document 46', 'Reviewed document 46', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-19 10:00:00'),



(47, 47, 'DOCUMENT_CREATED', 'DEVELOPER', 29, '{"provider": "GITHUB", "sourceIds": ["repo-47", "page-47"]}', '{"snapshot": "snapshot-47"}', '{"overview": "Draft for project 47"}', '{"overview": "COMPLETED"}', 'Project document 47', 'Reviewed document 47', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-20 10:00:00'),



(48, 48, 'REVIEWED', 'PM', 36, '{"provider": "GITHUB", "sourceIds": ["repo-48", "page-48"]}', '{"snapshot": "snapshot-48"}', '{"overview": "Draft for project 48"}', '{"overview": "COMPLETED"}', 'Project document 48', 'Reviewed document 48', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-21 10:00:00'),



(49, 49, 'PPT_CREATED', 'PM', 43, '{"provider": "GITHUB", "sourceIds": ["repo-49", "page-49"]}', '{"snapshot": "snapshot-49"}', '{"overview": "Draft for project 49"}', '{"overview": "COMPLETED"}', 'Project document 49', 'Reviewed document 49', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-22 10:00:00'),



(50, 50, 'NOT_STARTED', 'DEVELOPER', 50, '{"provider": "GITHUB", "sourceIds": ["repo-50", "page-50"]}', '{"snapshot": "snapshot-50"}', '{"overview": "Draft for project 50"}', '{"overview": "COMPLETED"}', 'Project document 50', 'Reviewed document 50', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-23 10:00:00'),



(51, 51, 'WRITING', 'DEVELOPER', 57, '{"provider": "GITHUB", "sourceIds": ["repo-51", "page-51"]}', '{"snapshot": "snapshot-51"}', '{"overview": "Draft for project 51"}', '{"overview": "COMPLETED"}', 'Project document 51', 'Reviewed document 51', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-24 10:00:00'),



(52, 52, 'DOCUMENT_CREATED', 'PM', 64, '{"provider": "GITHUB", "sourceIds": ["repo-52", "page-52"]}', '{"snapshot": "snapshot-52"}', '{"overview": "Draft for project 52"}', '{"overview": "COMPLETED"}', 'Project document 52', 'Reviewed document 52', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-25 10:00:00'),



(53, 53, 'REVIEWED', 'PM', 71, '{"provider": "GITHUB", "sourceIds": ["repo-53", "page-53"]}', '{"snapshot": "snapshot-53"}', '{"overview": "Draft for project 53"}', '{"overview": "COMPLETED"}', 'Project document 53', 'Reviewed document 53', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-26 10:00:00'),



(54, 54, 'PPT_CREATED', 'DEVELOPER', 78, '{"provider": "GITHUB", "sourceIds": ["repo-54", "page-54"]}', '{"snapshot": "snapshot-54"}', '{"overview": "Draft for project 54"}', '{"overview": "COMPLETED"}', 'Project document 54', 'Reviewed document 54', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-27 10:00:00'),



(55, 55, 'NOT_STARTED', 'DEVELOPER', 85, '{"provider": "GITHUB", "sourceIds": ["repo-55", "page-55"]}', '{"snapshot": "snapshot-55"}', '{"overview": "Draft for project 55"}', '{"overview": "COMPLETED"}', 'Project document 55', 'Reviewed document 55', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-28 10:00:00'),



(56, 56, 'WRITING', 'PM', 92, '{"provider": "GITHUB", "sourceIds": ["repo-56", "page-56"]}', '{"snapshot": "snapshot-56"}', '{"overview": "Draft for project 56"}', '{"overview": "COMPLETED"}', 'Project document 56', 'Reviewed document 56', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-01 10:00:00'),



(57, 57, 'DOCUMENT_CREATED', 'PM', 99, '{"provider": "GITHUB", "sourceIds": ["repo-57", "page-57"]}', '{"snapshot": "snapshot-57"}', '{"overview": "Draft for project 57"}', '{"overview": "COMPLETED"}', 'Project document 57', 'Reviewed document 57', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-02 10:00:00'),



(58, 58, 'REVIEWED', 'DEVELOPER', 6, '{"provider": "GITHUB", "sourceIds": ["repo-58", "page-58"]}', '{"snapshot": "snapshot-58"}', '{"overview": "Draft for project 58"}', '{"overview": "COMPLETED"}', 'Project document 58', 'Reviewed document 58', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-03 10:00:00'),



(59, 59, 'PPT_CREATED', 'DEVELOPER', 13, '{"provider": "GITHUB", "sourceIds": ["repo-59", "page-59"]}', '{"snapshot": "snapshot-59"}', '{"overview": "Draft for project 59"}', '{"overview": "COMPLETED"}', 'Project document 59', 'Reviewed document 59', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-04 10:00:00'),



(60, 60, 'NOT_STARTED', 'PM', 20, '{"provider": "GITHUB", "sourceIds": ["repo-60", "page-60"]}', '{"snapshot": "snapshot-60"}', '{"overview": "Draft for project 60"}', '{"overview": "COMPLETED"}', 'Project document 60', 'Reviewed document 60', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-05 10:00:00'),



(61, 61, 'WRITING', 'PM', 27, '{"provider": "GITHUB", "sourceIds": ["repo-61", "page-61"]}', '{"snapshot": "snapshot-61"}', '{"overview": "Draft for project 61"}', '{"overview": "COMPLETED"}', 'Project document 61', 'Reviewed document 61', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-06 10:00:00'),



(62, 62, 'DOCUMENT_CREATED', 'DEVELOPER', 34, '{"provider": "GITHUB", "sourceIds": ["repo-62", "page-62"]}', '{"snapshot": "snapshot-62"}', '{"overview": "Draft for project 62"}', '{"overview": "COMPLETED"}', 'Project document 62', 'Reviewed document 62', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-07 10:00:00'),



(63, 63, 'REVIEWED', 'DEVELOPER', 41, '{"provider": "GITHUB", "sourceIds": ["repo-63", "page-63"]}', '{"snapshot": "snapshot-63"}', '{"overview": "Draft for project 63"}', '{"overview": "COMPLETED"}', 'Project document 63', 'Reviewed document 63', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-08 10:00:00'),



(64, 64, 'PPT_CREATED', 'PM', 48, '{"provider": "GITHUB", "sourceIds": ["repo-64", "page-64"]}', '{"snapshot": "snapshot-64"}', '{"overview": "Draft for project 64"}', '{"overview": "COMPLETED"}', 'Project document 64', 'Reviewed document 64', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-09 10:00:00'),



(65, 65, 'NOT_STARTED', 'PM', 55, '{"provider": "GITHUB", "sourceIds": ["repo-65", "page-65"]}', '{"snapshot": "snapshot-65"}', '{"overview": "Draft for project 65"}', '{"overview": "COMPLETED"}', 'Project document 65', 'Reviewed document 65', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-10 10:00:00'),



(66, 66, 'WRITING', 'DEVELOPER', 62, '{"provider": "GITHUB", "sourceIds": ["repo-66", "page-66"]}', '{"snapshot": "snapshot-66"}', '{"overview": "Draft for project 66"}', '{"overview": "COMPLETED"}', 'Project document 66', 'Reviewed document 66', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-11 10:00:00'),



(67, 67, 'DOCUMENT_CREATED', 'DEVELOPER', 69, '{"provider": "GITHUB", "sourceIds": ["repo-67", "page-67"]}', '{"snapshot": "snapshot-67"}', '{"overview": "Draft for project 67"}', '{"overview": "COMPLETED"}', 'Project document 67', 'Reviewed document 67', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-12 10:00:00'),



(68, 68, 'REVIEWED', 'PM', 76, '{"provider": "GITHUB", "sourceIds": ["repo-68", "page-68"]}', '{"snapshot": "snapshot-68"}', '{"overview": "Draft for project 68"}', '{"overview": "COMPLETED"}', 'Project document 68', 'Reviewed document 68', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-13 10:00:00'),



(69, 69, 'PPT_CREATED', 'PM', 83, '{"provider": "GITHUB", "sourceIds": ["repo-69", "page-69"]}', '{"snapshot": "snapshot-69"}', '{"overview": "Draft for project 69"}', '{"overview": "COMPLETED"}', 'Project document 69', 'Reviewed document 69', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-14 10:00:00'),



(70, 70, 'NOT_STARTED', 'DEVELOPER', 90, '{"provider": "GITHUB", "sourceIds": ["repo-70", "page-70"]}', '{"snapshot": "snapshot-70"}', '{"overview": "Draft for project 70"}', '{"overview": "COMPLETED"}', 'Project document 70', 'Reviewed document 70', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-15 10:00:00'),



(71, 71, 'WRITING', 'DEVELOPER', 97, '{"provider": "GITHUB", "sourceIds": ["repo-71", "page-71"]}', '{"snapshot": "snapshot-71"}', '{"overview": "Draft for project 71"}', '{"overview": "COMPLETED"}', 'Project document 71', 'Reviewed document 71', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-16 10:00:00'),



(72, 72, 'DOCUMENT_CREATED', 'PM', 4, '{"provider": "GITHUB", "sourceIds": ["repo-72", "page-72"]}', '{"snapshot": "snapshot-72"}', '{"overview": "Draft for project 72"}', '{"overview": "COMPLETED"}', 'Project document 72', 'Reviewed document 72', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-17 10:00:00'),



(73, 73, 'REVIEWED', 'PM', 11, '{"provider": "GITHUB", "sourceIds": ["repo-73", "page-73"]}', '{"snapshot": "snapshot-73"}', '{"overview": "Draft for project 73"}', '{"overview": "COMPLETED"}', 'Project document 73', 'Reviewed document 73', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-18 10:00:00'),



(74, 74, 'PPT_CREATED', 'DEVELOPER', 18, '{"provider": "GITHUB", "sourceIds": ["repo-74", "page-74"]}', '{"snapshot": "snapshot-74"}', '{"overview": "Draft for project 74"}', '{"overview": "COMPLETED"}', 'Project document 74', 'Reviewed document 74', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-19 10:00:00'),



(75, 75, 'NOT_STARTED', 'DEVELOPER', 25, '{"provider": "GITHUB", "sourceIds": ["repo-75", "page-75"]}', '{"snapshot": "snapshot-75"}', '{"overview": "Draft for project 75"}', '{"overview": "COMPLETED"}', 'Project document 75', 'Reviewed document 75', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-20 10:00:00'),



(76, 76, 'WRITING', 'PM', 32, '{"provider": "GITHUB", "sourceIds": ["repo-76", "page-76"]}', '{"snapshot": "snapshot-76"}', '{"overview": "Draft for project 76"}', '{"overview": "COMPLETED"}', 'Project document 76', 'Reviewed document 76', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-21 10:00:00'),



(77, 77, 'DOCUMENT_CREATED', 'PM', 39, '{"provider": "GITHUB", "sourceIds": ["repo-77", "page-77"]}', '{"snapshot": "snapshot-77"}', '{"overview": "Draft for project 77"}', '{"overview": "COMPLETED"}', 'Project document 77', 'Reviewed document 77', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-22 10:00:00'),



(78, 78, 'REVIEWED', 'DEVELOPER', 46, '{"provider": "GITHUB", "sourceIds": ["repo-78", "page-78"]}', '{"snapshot": "snapshot-78"}', '{"overview": "Draft for project 78"}', '{"overview": "COMPLETED"}', 'Project document 78', 'Reviewed document 78', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-23 10:00:00'),



(79, 79, 'PPT_CREATED', 'DEVELOPER', 53, '{"provider": "GITHUB", "sourceIds": ["repo-79", "page-79"]}', '{"snapshot": "snapshot-79"}', '{"overview": "Draft for project 79"}', '{"overview": "COMPLETED"}', 'Project document 79', 'Reviewed document 79', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-24 10:00:00'),



(80, 80, 'NOT_STARTED', 'PM', 60, '{"provider": "GITHUB", "sourceIds": ["repo-80", "page-80"]}', '{"snapshot": "snapshot-80"}', '{"overview": "Draft for project 80"}', '{"overview": "COMPLETED"}', 'Project document 80', 'Reviewed document 80', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-25 10:00:00');



INSERT INTO project_writing_sessions (id, project_id, status, role, progress, selected_sources_json, source_snapshot_json, section_draft_json, section_status_json, document_text, reviewed_document, presentation_json, last_error, last_saved_at) VALUES



(81, 81, 'WRITING', 'PM', 67, '{"provider": "GITHUB", "sourceIds": ["repo-81", "page-81"]}', '{"snapshot": "snapshot-81"}', '{"overview": "Draft for project 81"}', '{"overview": "COMPLETED"}', 'Project document 81', 'Reviewed document 81', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-26 10:00:00'),



(82, 82, 'DOCUMENT_CREATED', 'DEVELOPER', 74, '{"provider": "GITHUB", "sourceIds": ["repo-82", "page-82"]}', '{"snapshot": "snapshot-82"}', '{"overview": "Draft for project 82"}', '{"overview": "COMPLETED"}', 'Project document 82', 'Reviewed document 82', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-27 10:00:00'),



(83, 83, 'REVIEWED', 'DEVELOPER', 81, '{"provider": "GITHUB", "sourceIds": ["repo-83", "page-83"]}', '{"snapshot": "snapshot-83"}', '{"overview": "Draft for project 83"}', '{"overview": "COMPLETED"}', 'Project document 83', 'Reviewed document 83', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-28 10:00:00'),



(84, 84, 'PPT_CREATED', 'PM', 88, '{"provider": "GITHUB", "sourceIds": ["repo-84", "page-84"]}', '{"snapshot": "snapshot-84"}', '{"overview": "Draft for project 84"}', '{"overview": "COMPLETED"}', 'Project document 84', 'Reviewed document 84', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-01 10:00:00'),



(85, 85, 'NOT_STARTED', 'PM', 95, '{"provider": "GITHUB", "sourceIds": ["repo-85", "page-85"]}', '{"snapshot": "snapshot-85"}', '{"overview": "Draft for project 85"}', '{"overview": "COMPLETED"}', 'Project document 85', 'Reviewed document 85', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-02 10:00:00'),



(86, 86, 'WRITING', 'DEVELOPER', 2, '{"provider": "GITHUB", "sourceIds": ["repo-86", "page-86"]}', '{"snapshot": "snapshot-86"}', '{"overview": "Draft for project 86"}', '{"overview": "COMPLETED"}', 'Project document 86', 'Reviewed document 86', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-03 10:00:00'),



(87, 87, 'DOCUMENT_CREATED', 'DEVELOPER', 9, '{"provider": "GITHUB", "sourceIds": ["repo-87", "page-87"]}', '{"snapshot": "snapshot-87"}', '{"overview": "Draft for project 87"}', '{"overview": "COMPLETED"}', 'Project document 87', 'Reviewed document 87', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-04 10:00:00'),



(88, 88, 'REVIEWED', 'PM', 16, '{"provider": "GITHUB", "sourceIds": ["repo-88", "page-88"]}', '{"snapshot": "snapshot-88"}', '{"overview": "Draft for project 88"}', '{"overview": "COMPLETED"}', 'Project document 88', 'Reviewed document 88', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-05 10:00:00'),



(89, 89, 'PPT_CREATED', 'PM', 23, '{"provider": "GITHUB", "sourceIds": ["repo-89", "page-89"]}', '{"snapshot": "snapshot-89"}', '{"overview": "Draft for project 89"}', '{"overview": "COMPLETED"}', 'Project document 89', 'Reviewed document 89', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-06 10:00:00'),



(90, 90, 'NOT_STARTED', 'DEVELOPER', 30, '{"provider": "GITHUB", "sourceIds": ["repo-90", "page-90"]}', '{"snapshot": "snapshot-90"}', '{"overview": "Draft for project 90"}', '{"overview": "COMPLETED"}', 'Project document 90', 'Reviewed document 90', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-07 10:00:00'),



(91, 91, 'WRITING', 'DEVELOPER', 37, '{"provider": "GITHUB", "sourceIds": ["repo-91", "page-91"]}', '{"snapshot": "snapshot-91"}', '{"overview": "Draft for project 91"}', '{"overview": "COMPLETED"}', 'Project document 91', 'Reviewed document 91', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-08 10:00:00'),



(92, 92, 'DOCUMENT_CREATED', 'PM', 44, '{"provider": "GITHUB", "sourceIds": ["repo-92", "page-92"]}', '{"snapshot": "snapshot-92"}', '{"overview": "Draft for project 92"}', '{"overview": "COMPLETED"}', 'Project document 92', 'Reviewed document 92', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-09 10:00:00'),



(93, 93, 'REVIEWED', 'PM', 51, '{"provider": "GITHUB", "sourceIds": ["repo-93", "page-93"]}', '{"snapshot": "snapshot-93"}', '{"overview": "Draft for project 93"}', '{"overview": "COMPLETED"}', 'Project document 93', 'Reviewed document 93', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-10 10:00:00'),



(94, 94, 'PPT_CREATED', 'DEVELOPER', 58, '{"provider": "GITHUB", "sourceIds": ["repo-94", "page-94"]}', '{"snapshot": "snapshot-94"}', '{"overview": "Draft for project 94"}', '{"overview": "COMPLETED"}', 'Project document 94', 'Reviewed document 94', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-11 10:00:00'),



(95, 95, 'NOT_STARTED', 'DEVELOPER', 65, '{"provider": "GITHUB", "sourceIds": ["repo-95", "page-95"]}', '{"snapshot": "snapshot-95"}', '{"overview": "Draft for project 95"}', '{"overview": "COMPLETED"}', 'Project document 95', 'Reviewed document 95', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-12 10:00:00'),



(96, 96, 'WRITING', 'PM', 72, '{"provider": "GITHUB", "sourceIds": ["repo-96", "page-96"]}', '{"snapshot": "snapshot-96"}', '{"overview": "Draft for project 96"}', '{"overview": "COMPLETED"}', 'Project document 96', 'Reviewed document 96', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-13 10:00:00'),



(97, 97, 'DOCUMENT_CREATED', 'PM', 79, '{"provider": "GITHUB", "sourceIds": ["repo-97", "page-97"]}', '{"snapshot": "snapshot-97"}', '{"overview": "Draft for project 97"}', '{"overview": "COMPLETED"}', 'Project document 97', 'Reviewed document 97', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-14 10:00:00'),



(98, 98, 'REVIEWED', 'DEVELOPER', 86, '{"provider": "GITHUB", "sourceIds": ["repo-98", "page-98"]}', '{"snapshot": "snapshot-98"}', '{"overview": "Draft for project 98"}', '{"overview": "COMPLETED"}', 'Project document 98', 'Reviewed document 98', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-15 10:00:00'),



(99, 99, 'PPT_CREATED', 'DEVELOPER', 93, '{"provider": "GITHUB", "sourceIds": ["repo-99", "page-99"]}', '{"snapshot": "snapshot-99"}', '{"overview": "Draft for project 99"}', '{"overview": "COMPLETED"}', 'Project document 99', 'Reviewed document 99', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-16 10:00:00'),



(100, 100, 'NOT_STARTED', 'PM', 0, '{"provider": "GITHUB", "sourceIds": ["repo-100", "page-100"]}', '{"snapshot": "snapshot-100"}', '{"overview": "Draft for project 100"}', '{"overview": "COMPLETED"}', 'Project document 100', 'Reviewed document 100', '{"slides": 12, "theme": "modern"}', NULL, '2026-06-17 10:00:00');







INSERT INTO project_documents (id, project_id, category, icon, title, read_time_minutes, order_index) VALUES



(1, 1, '프로젝트 개요', '📄', '프로젝트 개요 설명 1', 5, 1),



(2, 2, '담당 역할', '👤', '담당 역할 설명 2', 6, 2),



(3, 3, '문제 정의', '🖼', '문제 정의 설명 3', 7, 3),



(4, 4, '기술 스택', '🧰', '기술 스택 설명 4', 8, 4),



(5, 5, '시스템 구조', '🖥', '시스템 구조 설명 5', 4, 5),



(6, 6, '핵심 구추', '⚙️', '핵심 구추 설명 6', 5, 6),



(7, 7, '트루블슈팅', '🧮', '트루블슈팅 설명 7', 6, 7),



(8, 8, '성능 개선', '🚀', '성능 개선 설명 8', 7, 8),



(9, 9, '결과', '🏁', '결과 설명 9', 8, 9),



(10, 10, '회고', '📝', '회고 설명 10', 4, 10),



(11, 11, '프로젝트 개요', '📄', '프로젝트 개요 설명 11', 5, 11),



(12, 12, '담당 역할', '👤', '담당 역할 설명 12', 6, 12),



(13, 13, '문제 정의', '🖼', '문제 정의 설명 13', 7, 13),



(14, 14, '기술 스택', '🧰', '기술 스택 설명 14', 8, 14),



(15, 15, '시스템 구조', '🖥', '시스템 구조 설명 15', 4, 15),



(16, 16, '핵심 구추', '⚙️', '핵심 구추 설명 16', 5, 16),



(17, 17, '트루블슈팅', '🧮', '트루블슈팅 설명 17', 6, 17),



(18, 18, '성능 개선', '🚀', '성능 개선 설명 18', 7, 18),



(19, 19, '결과', '🏁', '결과 설명 19', 8, 19),



(20, 20, '회고', '📝', '회고 설명 20', 4, 20),



(21, 21, '프로젝트 개요', '📄', '프로젝트 개요 설명 21', 5, 21),



(22, 22, '담당 역할', '👤', '담당 역할 설명 22', 6, 22),



(23, 23, '문제 정의', '🖼', '문제 정의 설명 23', 7, 23),



(24, 24, '기술 스택', '🧰', '기술 스택 설명 24', 8, 24),



(25, 25, '시스템 구조', '🖥', '시스템 구조 설명 25', 4, 25),



(26, 26, '핵심 구추', '⚙️', '핵심 구추 설명 26', 5, 26),



(27, 27, '트루블슈팅', '🧮', '트루블슈팅 설명 27', 6, 27),



(28, 28, '성능 개선', '🚀', '성능 개선 설명 28', 7, 28),



(29, 29, '결과', '🏁', '결과 설명 29', 8, 29),



(30, 30, '회고', '📝', '회고 설명 30', 4, 30),



(31, 31, '프로젝트 개요', '📄', '프로젝트 개요 설명 31', 5, 31),



(32, 32, '담당 역할', '👤', '담당 역할 설명 32', 6, 32),



(33, 33, '문제 정의', '🖼', '문제 정의 설명 33', 7, 33),



(34, 34, '기술 스택', '🧰', '기술 스택 설명 34', 8, 34),



(35, 35, '시스템 구조', '🖥', '시스템 구조 설명 35', 4, 35),



(36, 36, '핵심 구추', '⚙️', '핵심 구추 설명 36', 5, 36),



(37, 37, '트루블슈팅', '🧮', '트루블슈팅 설명 37', 6, 37),



(38, 38, '성능 개선', '🚀', '성능 개선 설명 38', 7, 38),



(39, 39, '결과', '🏁', '결과 설명 39', 8, 39),



(40, 40, '회고', '📝', '회고 설명 40', 4, 40),



(41, 41, '프로젝트 개요', '📄', '프로젝트 개요 설명 41', 5, 41),



(42, 42, '담당 역할', '👤', '담당 역할 설명 42', 6, 42),



(43, 43, '문제 정의', '🖼', '문제 정의 설명 43', 7, 43),



(44, 44, '기술 스택', '🧰', '기술 스택 설명 44', 8, 44),



(45, 45, '시스템 구조', '🖥', '시스템 구조 설명 45', 4, 45),



(46, 46, '핵심 구추', '⚙️', '핵심 구추 설명 46', 5, 46),



(47, 47, '트루블슈팅', '🧮', '트루블슈팅 설명 47', 6, 47),



(48, 48, '성능 개선', '🚀', '성능 개선 설명 48', 7, 48),



(49, 49, '결과', '🏁', '결과 설명 49', 8, 49),



(50, 50, '회고', '📝', '회고 설명 50', 4, 50);



INSERT INTO project_documents (id, project_id, category, icon, title, read_time_minutes, order_index) VALUES



(51, 51, '프로젝트 개요', '📄', '프로젝트 개요 설명 51', 5, 51),



(52, 52, '담당 역할', '👤', '담당 역할 설명 52', 6, 52),



(53, 53, '문제 정의', '🖼', '문제 정의 설명 53', 7, 53),



(54, 54, '기술 스택', '🧰', '기술 스택 설명 54', 8, 54),



(55, 55, '시스템 구조', '🖥', '시스템 구조 설명 55', 4, 55),



(56, 56, '핵심 구추', '⚙️', '핵심 구추 설명 56', 5, 56),



(57, 57, '트루블슈팅', '🧮', '트루블슈팅 설명 57', 6, 57),



(58, 58, '성능 개선', '🚀', '성능 개선 설명 58', 7, 58),



(59, 59, '결과', '🏁', '결과 설명 59', 8, 59),



(60, 60, '회고', '📝', '회고 설명 60', 4, 60),



(61, 61, '프로젝트 개요', '📄', '프로젝트 개요 설명 61', 5, 61),



(62, 62, '담당 역할', '👤', '담당 역할 설명 62', 6, 62),



(63, 63, '문제 정의', '🖼', '문제 정의 설명 63', 7, 63),



(64, 64, '기술 스택', '🧰', '기술 스택 설명 64', 8, 64),



(65, 65, '시스템 구조', '🖥', '시스템 구조 설명 65', 4, 65),



(66, 66, '핵심 구추', '⚙️', '핵심 구추 설명 66', 5, 66),



(67, 67, '트루블슈팅', '🧮', '트루블슈팅 설명 67', 6, 67),



(68, 68, '성능 개선', '🚀', '성능 개선 설명 68', 7, 68),



(69, 69, '결과', '🏁', '결과 설명 69', 8, 69),



(70, 70, '회고', '📝', '회고 설명 70', 4, 70),



(71, 71, '프로젝트 개요', '📄', '프로젝트 개요 설명 71', 5, 71),



(72, 72, '담당 역할', '👤', '담당 역할 설명 72', 6, 72),



(73, 73, '문제 정의', '🖼', '문제 정의 설명 73', 7, 73),



(74, 74, '기술 스택', '🧰', '기술 스택 설명 74', 8, 74),



(75, 75, '시스템 구조', '🖥', '시스템 구조 설명 75', 4, 75),



(76, 76, '핵심 구추', '⚙️', '핵심 구추 설명 76', 5, 76),



(77, 77, '트루블슈팅', '🧮', '트루블슈팅 설명 77', 6, 77),



(78, 78, '성능 개선', '🚀', '성능 개선 설명 78', 7, 78),



(79, 79, '결과', '🏁', '결과 설명 79', 8, 79),



(80, 80, '회고', '📝', '회고 설명 80', 4, 80),



(81, 81, '프로젝트 개요', '📄', '프로젝트 개요 설명 81', 5, 81),



(82, 82, '담당 역할', '👤', '담당 역할 설명 82', 6, 82),



(83, 83, '문제 정의', '🖼', '문제 정의 설명 83', 7, 83),



(84, 84, '기술 스택', '🧰', '기술 스택 설명 84', 8, 84),



(85, 85, '시스템 구조', '🖥', '시스템 구조 설명 85', 4, 85),



(86, 86, '핵심 구추', '⚙️', '핵심 구추 설명 86', 5, 86),



(87, 87, '트루블슈팅', '🧮', '트루블슈팅 설명 87', 6, 87),



(88, 88, '성능 개선', '🚀', '성능 개선 설명 88', 7, 88),



(89, 89, '결과', '🏁', '결과 설명 89', 8, 89),



(90, 90, '회고', '📝', '회고 설명 90', 4, 90),



(91, 91, '프로젝트 개요', '📄', '프로젝트 개요 설명 91', 5, 91),



(92, 92, '담당 역할', '👤', '담당 역할 설명 92', 6, 92),



(93, 93, '문제 정의', '🖼', '문제 정의 설명 93', 7, 93),



(94, 94, '기술 스택', '🧰', '기술 스택 설명 94', 8, 94),



(95, 95, '시스템 구조', '🖥', '시스템 구조 설명 95', 4, 95),



(96, 96, '핵심 구추', '⚙️', '핵심 구추 설명 96', 5, 96),



(97, 97, '트루블슈팅', '🧮', '트루블슈팅 설명 97', 6, 97),



(98, 98, '성능 개선', '🚀', '성능 개선 설명 98', 7, 98),



(99, 99, '결과', '🏁', '결과 설명 99', 8, 99),



(100, 100, '회고', '📝', '회고 설명 100', 4, 100);



INSERT INTO blocks (id, document_id, parent_id, block_type, content, order_index) VALUES



(1, 1, NULL, 'TEXT', '{"text": "TROUBLESHOOTING block 1 for document 1", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(2, 1, NULL, 'HEADING_1', '{"text": "TROUBLESHOOTING heading 2"}'::jsonb, 2),



(3, 1, NULL, 'HEADING_2', '{"text": "TROUBLESHOOTING heading 3"}'::jsonb, 3),



(4, 1, NULL, 'HEADING_3', '{"text": "TROUBLESHOOTING heading 4"}'::jsonb, 4),



(5, 1, NULL, 'BULLETED_LIST', '{"items": ["TROUBLESHOOTING item 5a", "TROUBLESHOOTING item 5b"]}'::jsonb, 5),



(6, 1, NULL, 'NUMBERED_LIST', '{"items": ["TROUBLESHOOTING item 6a", "TROUBLESHOOTING item 6b"]}'::jsonb, 6),



(7, 1, NULL, 'TODO', '{"items": ["TROUBLESHOOTING item 7a", "TROUBLESHOOTING item 7b"]}'::jsonb, 7),



(8, 1, NULL, 'TOGGLE', '{"text": "TROUBLESHOOTING block 8 for document 1", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(9, 1, NULL, 'QUOTE', '{"text": "TROUBLESHOOTING block 9 for document 1", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(10, 1, NULL, 'CALLOUT', '{"text": "TROUBLESHOOTING block 10 for document 1", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(11, 2, NULL, 'TEXT', '{"text": "ROLE block 1 for document 2", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(12, 2, NULL, 'HEADING_1', '{"text": "ROLE heading 2"}'::jsonb, 2),



(13, 2, NULL, 'HEADING_2', '{"text": "ROLE heading 3"}'::jsonb, 3),



(14, 2, NULL, 'HEADING_3', '{"text": "ROLE heading 4"}'::jsonb, 4),



(15, 2, NULL, 'BULLETED_LIST', '{"items": ["ROLE item 5a", "ROLE item 5b"]}'::jsonb, 5),



(16, 2, NULL, 'NUMBERED_LIST', '{"items": ["ROLE item 6a", "ROLE item 6b"]}'::jsonb, 6),



(17, 2, NULL, 'TODO', '{"items": ["ROLE item 7a", "ROLE item 7b"]}'::jsonb, 7),



(18, 2, NULL, 'TOGGLE', '{"text": "ROLE block 8 for document 2", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(19, 2, NULL, 'QUOTE', '{"text": "ROLE block 9 for document 2", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(20, 2, NULL, 'CALLOUT', '{"text": "ROLE block 10 for document 2", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(21, 3, NULL, 'TEXT', '{"text": "TECH_STACK block 1 for document 3", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(22, 3, NULL, 'HEADING_1', '{"text": "TECH_STACK heading 2"}'::jsonb, 2),



(23, 3, NULL, 'HEADING_2', '{"text": "TECH_STACK heading 3"}'::jsonb, 3),



(24, 3, NULL, 'HEADING_3', '{"text": "TECH_STACK heading 4"}'::jsonb, 4),



(25, 3, NULL, 'BULLETED_LIST', '{"items": ["TECH_STACK item 5a", "TECH_STACK item 5b"]}'::jsonb, 5),



(26, 3, NULL, 'NUMBERED_LIST', '{"items": ["TECH_STACK item 6a", "TECH_STACK item 6b"]}'::jsonb, 6),



(27, 3, NULL, 'TODO', '{"items": ["TECH_STACK item 7a", "TECH_STACK item 7b"]}'::jsonb, 7),



(28, 3, NULL, 'TOGGLE', '{"text": "TECH_STACK block 8 for document 3", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(29, 3, NULL, 'QUOTE', '{"text": "TECH_STACK block 9 for document 3", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(30, 3, NULL, 'CALLOUT', '{"text": "TECH_STACK block 10 for document 3", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(31, 4, NULL, 'TEXT', '{"text": "PROCESS block 1 for document 4", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(32, 4, NULL, 'HEADING_1', '{"text": "PROCESS heading 2"}'::jsonb, 2),



(33, 4, NULL, 'HEADING_2', '{"text": "PROCESS heading 3"}'::jsonb, 3),



(34, 4, NULL, 'HEADING_3', '{"text": "PROCESS heading 4"}'::jsonb, 4),



(35, 4, NULL, 'BULLETED_LIST', '{"items": ["PROCESS item 5a", "PROCESS item 5b"]}'::jsonb, 5),



(36, 4, NULL, 'NUMBERED_LIST', '{"items": ["PROCESS item 6a", "PROCESS item 6b"]}'::jsonb, 6),



(37, 4, NULL, 'TODO', '{"items": ["PROCESS item 7a", "PROCESS item 7b"]}'::jsonb, 7),



(38, 4, NULL, 'TOGGLE', '{"text": "PROCESS block 8 for document 4", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(39, 4, NULL, 'QUOTE', '{"text": "PROCESS block 9 for document 4", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(40, 4, NULL, 'CALLOUT', '{"text": "PROCESS block 10 for document 4", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(41, 5, NULL, 'TEXT', '{"text": "RESULT block 1 for document 5", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(42, 5, NULL, 'HEADING_1', '{"text": "RESULT heading 2"}'::jsonb, 2),



(43, 5, NULL, 'HEADING_2', '{"text": "RESULT heading 3"}'::jsonb, 3),



(44, 5, NULL, 'HEADING_3', '{"text": "RESULT heading 4"}'::jsonb, 4),



(45, 5, NULL, 'BULLETED_LIST', '{"items": ["RESULT item 5a", "RESULT item 5b"]}'::jsonb, 5),



(46, 5, NULL, 'NUMBERED_LIST', '{"items": ["RESULT item 6a", "RESULT item 6b"]}'::jsonb, 6),



(47, 5, NULL, 'TODO', '{"items": ["RESULT item 7a", "RESULT item 7b"]}'::jsonb, 7),



(48, 5, NULL, 'TOGGLE', '{"text": "RESULT block 8 for document 5", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(49, 5, NULL, 'QUOTE', '{"text": "RESULT block 9 for document 5", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(50, 5, NULL, 'CALLOUT', '{"text": "RESULT block 10 for document 5", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(51, 6, NULL, 'TEXT', '{"text": "RETROSPECTIVE block 1 for document 6", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(52, 6, NULL, 'HEADING_1', '{"text": "RETROSPECTIVE heading 2"}'::jsonb, 2),



(53, 6, NULL, 'HEADING_2', '{"text": "RETROSPECTIVE heading 3"}'::jsonb, 3),



(54, 6, NULL, 'HEADING_3', '{"text": "RETROSPECTIVE heading 4"}'::jsonb, 4),



(55, 6, NULL, 'BULLETED_LIST', '{"items": ["RETROSPECTIVE item 5a", "RETROSPECTIVE item 5b"]}'::jsonb, 5),



(56, 6, NULL, 'NUMBERED_LIST', '{"items": ["RETROSPECTIVE item 6a", "RETROSPECTIVE item 6b"]}'::jsonb, 6),



(57, 6, NULL, 'TODO', '{"items": ["RETROSPECTIVE item 7a", "RETROSPECTIVE item 7b"]}'::jsonb, 7),



(58, 6, NULL, 'TOGGLE', '{"text": "RETROSPECTIVE block 8 for document 6", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(59, 6, NULL, 'QUOTE', '{"text": "RETROSPECTIVE block 9 for document 6", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(60, 6, NULL, 'CALLOUT', '{"text": "RETROSPECTIVE block 10 for document 6", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(61, 7, NULL, 'TEXT', '{"text": "DESIGN_STORY block 1 for document 7", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(62, 7, NULL, 'HEADING_1', '{"text": "DESIGN_STORY heading 2"}'::jsonb, 2),



(63, 7, NULL, 'HEADING_2', '{"text": "DESIGN_STORY heading 3"}'::jsonb, 3),



(64, 7, NULL, 'HEADING_3', '{"text": "DESIGN_STORY heading 4"}'::jsonb, 4),



(65, 7, NULL, 'BULLETED_LIST', '{"items": ["DESIGN_STORY item 5a", "DESIGN_STORY item 5b"]}'::jsonb, 5),



(66, 7, NULL, 'NUMBERED_LIST', '{"items": ["DESIGN_STORY item 6a", "DESIGN_STORY item 6b"]}'::jsonb, 6),



(67, 7, NULL, 'TODO', '{"items": ["DESIGN_STORY item 7a", "DESIGN_STORY item 7b"]}'::jsonb, 7),



(68, 7, NULL, 'TOGGLE', '{"text": "DESIGN_STORY block 8 for document 7", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(69, 7, NULL, 'QUOTE', '{"text": "DESIGN_STORY block 9 for document 7", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(70, 7, NULL, 'CALLOUT', '{"text": "DESIGN_STORY block 10 for document 7", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(71, 8, NULL, 'TEXT', '{"text": "MARKETING_STRATEGY block 1 for document 8", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(72, 8, NULL, 'HEADING_1', '{"text": "MARKETING_STRATEGY heading 2"}'::jsonb, 2),



(73, 8, NULL, 'HEADING_2', '{"text": "MARKETING_STRATEGY heading 3"}'::jsonb, 3),



(74, 8, NULL, 'HEADING_3', '{"text": "MARKETING_STRATEGY heading 4"}'::jsonb, 4),



(75, 8, NULL, 'BULLETED_LIST', '{"items": ["MARKETING_STRATEGY item 5a", "MARKETING_STRATEGY item 5b"]}'::jsonb, 5),



(76, 8, NULL, 'NUMBERED_LIST', '{"items": ["MARKETING_STRATEGY item 6a", "MARKETING_STRATEGY item 6b"]}'::jsonb, 6),



(77, 8, NULL, 'TODO', '{"items": ["MARKETING_STRATEGY item 7a", "MARKETING_STRATEGY item 7b"]}'::jsonb, 7),



(78, 8, NULL, 'TOGGLE', '{"text": "MARKETING_STRATEGY block 8 for document 8", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(79, 8, NULL, 'QUOTE', '{"text": "MARKETING_STRATEGY block 9 for document 8", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(80, 8, NULL, 'CALLOUT', '{"text": "MARKETING_STRATEGY block 10 for document 8", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(81, 9, NULL, 'TEXT', '{"text": "OTHER block 1 for document 9", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(82, 9, NULL, 'HEADING_1', '{"text": "OTHER heading 2"}'::jsonb, 2),



(83, 9, NULL, 'HEADING_2', '{"text": "OTHER heading 3"}'::jsonb, 3),



(84, 9, NULL, 'HEADING_3', '{"text": "OTHER heading 4"}'::jsonb, 4),



(85, 9, NULL, 'BULLETED_LIST', '{"items": ["OTHER item 5a", "OTHER item 5b"]}'::jsonb, 5),



(86, 9, NULL, 'NUMBERED_LIST', '{"items": ["OTHER item 6a", "OTHER item 6b"]}'::jsonb, 6),



(87, 9, NULL, 'TODO', '{"items": ["OTHER item 7a", "OTHER item 7b"]}'::jsonb, 7),



(88, 9, NULL, 'TOGGLE', '{"text": "OTHER block 8 for document 9", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(89, 9, NULL, 'QUOTE', '{"text": "OTHER block 9 for document 9", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(90, 9, NULL, 'CALLOUT', '{"text": "OTHER block 10 for document 9", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(91, 10, NULL, 'TEXT', '{"text": "TROUBLESHOOTING block 1 for document 10", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(92, 10, NULL, 'HEADING_1', '{"text": "TROUBLESHOOTING heading 2"}'::jsonb, 2),



(93, 10, NULL, 'HEADING_2', '{"text": "TROUBLESHOOTING heading 3"}'::jsonb, 3),



(94, 10, NULL, 'HEADING_3', '{"text": "TROUBLESHOOTING heading 4"}'::jsonb, 4),



(95, 10, NULL, 'BULLETED_LIST', '{"items": ["TROUBLESHOOTING item 5a", "TROUBLESHOOTING item 5b"]}'::jsonb, 5),



(96, 10, NULL, 'NUMBERED_LIST', '{"items": ["TROUBLESHOOTING item 6a", "TROUBLESHOOTING item 6b"]}'::jsonb, 6),



(97, 10, NULL, 'TODO', '{"items": ["TROUBLESHOOTING item 7a", "TROUBLESHOOTING item 7b"]}'::jsonb, 7),



(98, 10, NULL, 'TOGGLE', '{"text": "TROUBLESHOOTING block 8 for document 10", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(99, 10, NULL, 'QUOTE', '{"text": "TROUBLESHOOTING block 9 for document 10", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(100, 10, NULL, 'CALLOUT', '{"text": "TROUBLESHOOTING block 10 for document 10", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10);



INSERT INTO blocks (id, document_id, parent_id, block_type, content, order_index) VALUES



(101, 11, NULL, 'TEXT', '{"text": "ROLE block 1 for document 11", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(102, 11, NULL, 'HEADING_1', '{"text": "ROLE heading 2"}'::jsonb, 2),



(103, 11, NULL, 'HEADING_2', '{"text": "ROLE heading 3"}'::jsonb, 3),



(104, 11, NULL, 'HEADING_3', '{"text": "ROLE heading 4"}'::jsonb, 4),



(105, 11, NULL, 'BULLETED_LIST', '{"items": ["ROLE item 5a", "ROLE item 5b"]}'::jsonb, 5),



(106, 11, NULL, 'NUMBERED_LIST', '{"items": ["ROLE item 6a", "ROLE item 6b"]}'::jsonb, 6),



(107, 11, NULL, 'TODO', '{"items": ["ROLE item 7a", "ROLE item 7b"]}'::jsonb, 7),



(108, 11, NULL, 'TOGGLE', '{"text": "ROLE block 8 for document 11", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(109, 11, NULL, 'QUOTE', '{"text": "ROLE block 9 for document 11", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(110, 11, NULL, 'CALLOUT', '{"text": "ROLE block 10 for document 11", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(111, 12, NULL, 'TEXT', '{"text": "TECH_STACK block 1 for document 12", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(112, 12, NULL, 'HEADING_1', '{"text": "TECH_STACK heading 2"}'::jsonb, 2),



(113, 12, NULL, 'HEADING_2', '{"text": "TECH_STACK heading 3"}'::jsonb, 3),



(114, 12, NULL, 'HEADING_3', '{"text": "TECH_STACK heading 4"}'::jsonb, 4),



(115, 12, NULL, 'BULLETED_LIST', '{"items": ["TECH_STACK item 5a", "TECH_STACK item 5b"]}'::jsonb, 5),



(116, 12, NULL, 'NUMBERED_LIST', '{"items": ["TECH_STACK item 6a", "TECH_STACK item 6b"]}'::jsonb, 6),



(117, 12, NULL, 'TODO', '{"items": ["TECH_STACK item 7a", "TECH_STACK item 7b"]}'::jsonb, 7),



(118, 12, NULL, 'TOGGLE', '{"text": "TECH_STACK block 8 for document 12", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(119, 12, NULL, 'QUOTE', '{"text": "TECH_STACK block 9 for document 12", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(120, 12, NULL, 'CALLOUT', '{"text": "TECH_STACK block 10 for document 12", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(121, 13, NULL, 'TEXT', '{"text": "PROCESS block 1 for document 13", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(122, 13, NULL, 'HEADING_1', '{"text": "PROCESS heading 2"}'::jsonb, 2),



(123, 13, NULL, 'HEADING_2', '{"text": "PROCESS heading 3"}'::jsonb, 3),



(124, 13, NULL, 'HEADING_3', '{"text": "PROCESS heading 4"}'::jsonb, 4),



(125, 13, NULL, 'BULLETED_LIST', '{"items": ["PROCESS item 5a", "PROCESS item 5b"]}'::jsonb, 5),



(126, 13, NULL, 'NUMBERED_LIST', '{"items": ["PROCESS item 6a", "PROCESS item 6b"]}'::jsonb, 6),



(127, 13, NULL, 'TODO', '{"items": ["PROCESS item 7a", "PROCESS item 7b"]}'::jsonb, 7),



(128, 13, NULL, 'TOGGLE', '{"text": "PROCESS block 8 for document 13", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(129, 13, NULL, 'QUOTE', '{"text": "PROCESS block 9 for document 13", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(130, 13, NULL, 'CALLOUT', '{"text": "PROCESS block 10 for document 13", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(131, 14, NULL, 'TEXT', '{"text": "RESULT block 1 for document 14", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(132, 14, NULL, 'HEADING_1', '{"text": "RESULT heading 2"}'::jsonb, 2),



(133, 14, NULL, 'HEADING_2', '{"text": "RESULT heading 3"}'::jsonb, 3),



(134, 14, NULL, 'HEADING_3', '{"text": "RESULT heading 4"}'::jsonb, 4),



(135, 14, NULL, 'BULLETED_LIST', '{"items": ["RESULT item 5a", "RESULT item 5b"]}'::jsonb, 5),



(136, 14, NULL, 'NUMBERED_LIST', '{"items": ["RESULT item 6a", "RESULT item 6b"]}'::jsonb, 6),



(137, 14, NULL, 'TODO', '{"items": ["RESULT item 7a", "RESULT item 7b"]}'::jsonb, 7),



(138, 14, NULL, 'TOGGLE', '{"text": "RESULT block 8 for document 14", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(139, 14, NULL, 'QUOTE', '{"text": "RESULT block 9 for document 14", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(140, 14, NULL, 'CALLOUT', '{"text": "RESULT block 10 for document 14", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(141, 15, NULL, 'TEXT', '{"text": "RETROSPECTIVE block 1 for document 15", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(142, 15, NULL, 'HEADING_1', '{"text": "RETROSPECTIVE heading 2"}'::jsonb, 2),



(143, 15, NULL, 'HEADING_2', '{"text": "RETROSPECTIVE heading 3"}'::jsonb, 3),



(144, 15, NULL, 'HEADING_3', '{"text": "RETROSPECTIVE heading 4"}'::jsonb, 4),



(145, 15, NULL, 'BULLETED_LIST', '{"items": ["RETROSPECTIVE item 5a", "RETROSPECTIVE item 5b"]}'::jsonb, 5),



(146, 15, NULL, 'NUMBERED_LIST', '{"items": ["RETROSPECTIVE item 6a", "RETROSPECTIVE item 6b"]}'::jsonb, 6),



(147, 15, NULL, 'TODO', '{"items": ["RETROSPECTIVE item 7a", "RETROSPECTIVE item 7b"]}'::jsonb, 7),



(148, 15, NULL, 'TOGGLE', '{"text": "RETROSPECTIVE block 8 for document 15", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(149, 15, NULL, 'QUOTE', '{"text": "RETROSPECTIVE block 9 for document 15", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(150, 15, NULL, 'CALLOUT', '{"text": "RETROSPECTIVE block 10 for document 15", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(151, 16, NULL, 'TEXT', '{"text": "DESIGN_STORY block 1 for document 16", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(152, 16, NULL, 'HEADING_1', '{"text": "DESIGN_STORY heading 2"}'::jsonb, 2),



(153, 16, NULL, 'HEADING_2', '{"text": "DESIGN_STORY heading 3"}'::jsonb, 3),



(154, 16, NULL, 'HEADING_3', '{"text": "DESIGN_STORY heading 4"}'::jsonb, 4),



(155, 16, NULL, 'BULLETED_LIST', '{"items": ["DESIGN_STORY item 5a", "DESIGN_STORY item 5b"]}'::jsonb, 5),



(156, 16, NULL, 'NUMBERED_LIST', '{"items": ["DESIGN_STORY item 6a", "DESIGN_STORY item 6b"]}'::jsonb, 6),



(157, 16, NULL, 'TODO', '{"items": ["DESIGN_STORY item 7a", "DESIGN_STORY item 7b"]}'::jsonb, 7),



(158, 16, NULL, 'TOGGLE', '{"text": "DESIGN_STORY block 8 for document 16", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(159, 16, NULL, 'QUOTE', '{"text": "DESIGN_STORY block 9 for document 16", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(160, 16, NULL, 'CALLOUT', '{"text": "DESIGN_STORY block 10 for document 16", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(161, 17, NULL, 'TEXT', '{"text": "MARKETING_STRATEGY block 1 for document 17", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(162, 17, NULL, 'HEADING_1', '{"text": "MARKETING_STRATEGY heading 2"}'::jsonb, 2),



(163, 17, NULL, 'HEADING_2', '{"text": "MARKETING_STRATEGY heading 3"}'::jsonb, 3),



(164, 17, NULL, 'HEADING_3', '{"text": "MARKETING_STRATEGY heading 4"}'::jsonb, 4),



(165, 17, NULL, 'BULLETED_LIST', '{"items": ["MARKETING_STRATEGY item 5a", "MARKETING_STRATEGY item 5b"]}'::jsonb, 5),



(166, 17, NULL, 'NUMBERED_LIST', '{"items": ["MARKETING_STRATEGY item 6a", "MARKETING_STRATEGY item 6b"]}'::jsonb, 6),



(167, 17, NULL, 'TODO', '{"items": ["MARKETING_STRATEGY item 7a", "MARKETING_STRATEGY item 7b"]}'::jsonb, 7),



(168, 17, NULL, 'TOGGLE', '{"text": "MARKETING_STRATEGY block 8 for document 17", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(169, 17, NULL, 'QUOTE', '{"text": "MARKETING_STRATEGY block 9 for document 17", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(170, 17, NULL, 'CALLOUT', '{"text": "MARKETING_STRATEGY block 10 for document 17", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(171, 18, NULL, 'TEXT', '{"text": "OTHER block 1 for document 18", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(172, 18, NULL, 'HEADING_1', '{"text": "OTHER heading 2"}'::jsonb, 2),



(173, 18, NULL, 'HEADING_2', '{"text": "OTHER heading 3"}'::jsonb, 3),



(174, 18, NULL, 'HEADING_3', '{"text": "OTHER heading 4"}'::jsonb, 4),



(175, 18, NULL, 'BULLETED_LIST', '{"items": ["OTHER item 5a", "OTHER item 5b"]}'::jsonb, 5),



(176, 18, NULL, 'NUMBERED_LIST', '{"items": ["OTHER item 6a", "OTHER item 6b"]}'::jsonb, 6),



(177, 18, NULL, 'TODO', '{"items": ["OTHER item 7a", "OTHER item 7b"]}'::jsonb, 7),



(178, 18, NULL, 'TOGGLE', '{"text": "OTHER block 8 for document 18", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(179, 18, NULL, 'QUOTE', '{"text": "OTHER block 9 for document 18", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(180, 18, NULL, 'CALLOUT', '{"text": "OTHER block 10 for document 18", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(181, 19, NULL, 'TEXT', '{"text": "TROUBLESHOOTING block 1 for document 19", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(182, 19, NULL, 'HEADING_1', '{"text": "TROUBLESHOOTING heading 2"}'::jsonb, 2),



(183, 19, NULL, 'HEADING_2', '{"text": "TROUBLESHOOTING heading 3"}'::jsonb, 3),



(184, 19, NULL, 'HEADING_3', '{"text": "TROUBLESHOOTING heading 4"}'::jsonb, 4),



(185, 19, NULL, 'BULLETED_LIST', '{"items": ["TROUBLESHOOTING item 5a", "TROUBLESHOOTING item 5b"]}'::jsonb, 5),



(186, 19, NULL, 'NUMBERED_LIST', '{"items": ["TROUBLESHOOTING item 6a", "TROUBLESHOOTING item 6b"]}'::jsonb, 6),



(187, 19, NULL, 'TODO', '{"items": ["TROUBLESHOOTING item 7a", "TROUBLESHOOTING item 7b"]}'::jsonb, 7),



(188, 19, NULL, 'TOGGLE', '{"text": "TROUBLESHOOTING block 8 for document 19", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(189, 19, NULL, 'QUOTE', '{"text": "TROUBLESHOOTING block 9 for document 19", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(190, 19, NULL, 'CALLOUT', '{"text": "TROUBLESHOOTING block 10 for document 19", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(191, 20, NULL, 'TEXT', '{"text": "ROLE block 1 for document 20", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(192, 20, NULL, 'HEADING_1', '{"text": "ROLE heading 2"}'::jsonb, 2),



(193, 20, NULL, 'HEADING_2', '{"text": "ROLE heading 3"}'::jsonb, 3),



(194, 20, NULL, 'HEADING_3', '{"text": "ROLE heading 4"}'::jsonb, 4),



(195, 20, NULL, 'BULLETED_LIST', '{"items": ["ROLE item 5a", "ROLE item 5b"]}'::jsonb, 5),



(196, 20, NULL, 'NUMBERED_LIST', '{"items": ["ROLE item 6a", "ROLE item 6b"]}'::jsonb, 6),



(197, 20, NULL, 'TODO', '{"items": ["ROLE item 7a", "ROLE item 7b"]}'::jsonb, 7),



(198, 20, NULL, 'TOGGLE', '{"text": "ROLE block 8 for document 20", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(199, 20, NULL, 'QUOTE', '{"text": "ROLE block 9 for document 20", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(200, 20, NULL, 'CALLOUT', '{"text": "ROLE block 10 for document 20", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10);



INSERT INTO blocks (id, document_id, parent_id, block_type, content, order_index) VALUES



(201, 21, NULL, 'TEXT', '{"text": "TECH_STACK block 1 for document 21", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(202, 21, NULL, 'HEADING_1', '{"text": "TECH_STACK heading 2"}'::jsonb, 2),



(203, 21, NULL, 'HEADING_2', '{"text": "TECH_STACK heading 3"}'::jsonb, 3),



(204, 21, NULL, 'HEADING_3', '{"text": "TECH_STACK heading 4"}'::jsonb, 4),



(205, 21, NULL, 'BULLETED_LIST', '{"items": ["TECH_STACK item 5a", "TECH_STACK item 5b"]}'::jsonb, 5),



(206, 21, NULL, 'NUMBERED_LIST', '{"items": ["TECH_STACK item 6a", "TECH_STACK item 6b"]}'::jsonb, 6),



(207, 21, NULL, 'TODO', '{"items": ["TECH_STACK item 7a", "TECH_STACK item 7b"]}'::jsonb, 7),



(208, 21, NULL, 'TOGGLE', '{"text": "TECH_STACK block 8 for document 21", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(209, 21, NULL, 'QUOTE', '{"text": "TECH_STACK block 9 for document 21", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(210, 21, NULL, 'CALLOUT', '{"text": "TECH_STACK block 10 for document 21", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(211, 22, NULL, 'TEXT', '{"text": "PROCESS block 1 for document 22", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(212, 22, NULL, 'HEADING_1', '{"text": "PROCESS heading 2"}'::jsonb, 2),



(213, 22, NULL, 'HEADING_2', '{"text": "PROCESS heading 3"}'::jsonb, 3),



(214, 22, NULL, 'HEADING_3', '{"text": "PROCESS heading 4"}'::jsonb, 4),



(215, 22, NULL, 'BULLETED_LIST', '{"items": ["PROCESS item 5a", "PROCESS item 5b"]}'::jsonb, 5),



(216, 22, NULL, 'NUMBERED_LIST', '{"items": ["PROCESS item 6a", "PROCESS item 6b"]}'::jsonb, 6),



(217, 22, NULL, 'TODO', '{"items": ["PROCESS item 7a", "PROCESS item 7b"]}'::jsonb, 7),



(218, 22, NULL, 'TOGGLE', '{"text": "PROCESS block 8 for document 22", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(219, 22, NULL, 'QUOTE', '{"text": "PROCESS block 9 for document 22", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(220, 22, NULL, 'CALLOUT', '{"text": "PROCESS block 10 for document 22", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(221, 23, NULL, 'TEXT', '{"text": "RESULT block 1 for document 23", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(222, 23, NULL, 'HEADING_1', '{"text": "RESULT heading 2"}'::jsonb, 2),



(223, 23, NULL, 'HEADING_2', '{"text": "RESULT heading 3"}'::jsonb, 3),



(224, 23, NULL, 'HEADING_3', '{"text": "RESULT heading 4"}'::jsonb, 4),



(225, 23, NULL, 'BULLETED_LIST', '{"items": ["RESULT item 5a", "RESULT item 5b"]}'::jsonb, 5),



(226, 23, NULL, 'NUMBERED_LIST', '{"items": ["RESULT item 6a", "RESULT item 6b"]}'::jsonb, 6),



(227, 23, NULL, 'TODO', '{"items": ["RESULT item 7a", "RESULT item 7b"]}'::jsonb, 7),



(228, 23, NULL, 'TOGGLE', '{"text": "RESULT block 8 for document 23", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(229, 23, NULL, 'QUOTE', '{"text": "RESULT block 9 for document 23", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(230, 23, NULL, 'CALLOUT', '{"text": "RESULT block 10 for document 23", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(231, 24, NULL, 'TEXT', '{"text": "RETROSPECTIVE block 1 for document 24", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(232, 24, NULL, 'HEADING_1', '{"text": "RETROSPECTIVE heading 2"}'::jsonb, 2),



(233, 24, NULL, 'HEADING_2', '{"text": "RETROSPECTIVE heading 3"}'::jsonb, 3),



(234, 24, NULL, 'HEADING_3', '{"text": "RETROSPECTIVE heading 4"}'::jsonb, 4),



(235, 24, NULL, 'BULLETED_LIST', '{"items": ["RETROSPECTIVE item 5a", "RETROSPECTIVE item 5b"]}'::jsonb, 5),



(236, 24, NULL, 'NUMBERED_LIST', '{"items": ["RETROSPECTIVE item 6a", "RETROSPECTIVE item 6b"]}'::jsonb, 6),



(237, 24, NULL, 'TODO', '{"items": ["RETROSPECTIVE item 7a", "RETROSPECTIVE item 7b"]}'::jsonb, 7),



(238, 24, NULL, 'TOGGLE', '{"text": "RETROSPECTIVE block 8 for document 24", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(239, 24, NULL, 'QUOTE', '{"text": "RETROSPECTIVE block 9 for document 24", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(240, 24, NULL, 'CALLOUT', '{"text": "RETROSPECTIVE block 10 for document 24", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(241, 25, NULL, 'TEXT', '{"text": "DESIGN_STORY block 1 for document 25", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(242, 25, NULL, 'HEADING_1', '{"text": "DESIGN_STORY heading 2"}'::jsonb, 2),



(243, 25, NULL, 'HEADING_2', '{"text": "DESIGN_STORY heading 3"}'::jsonb, 3),



(244, 25, NULL, 'HEADING_3', '{"text": "DESIGN_STORY heading 4"}'::jsonb, 4),



(245, 25, NULL, 'BULLETED_LIST', '{"items": ["DESIGN_STORY item 5a", "DESIGN_STORY item 5b"]}'::jsonb, 5),



(246, 25, NULL, 'NUMBERED_LIST', '{"items": ["DESIGN_STORY item 6a", "DESIGN_STORY item 6b"]}'::jsonb, 6),



(247, 25, NULL, 'TODO', '{"items": ["DESIGN_STORY item 7a", "DESIGN_STORY item 7b"]}'::jsonb, 7),



(248, 25, NULL, 'TOGGLE', '{"text": "DESIGN_STORY block 8 for document 25", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(249, 25, NULL, 'QUOTE', '{"text": "DESIGN_STORY block 9 for document 25", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(250, 25, NULL, 'CALLOUT', '{"text": "DESIGN_STORY block 10 for document 25", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(251, 26, NULL, 'TEXT', '{"text": "MARKETING_STRATEGY block 1 for document 26", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(252, 26, NULL, 'HEADING_1', '{"text": "MARKETING_STRATEGY heading 2"}'::jsonb, 2),



(253, 26, NULL, 'HEADING_2', '{"text": "MARKETING_STRATEGY heading 3"}'::jsonb, 3),



(254, 26, NULL, 'HEADING_3', '{"text": "MARKETING_STRATEGY heading 4"}'::jsonb, 4),



(255, 26, NULL, 'BULLETED_LIST', '{"items": ["MARKETING_STRATEGY item 5a", "MARKETING_STRATEGY item 5b"]}'::jsonb, 5),



(256, 26, NULL, 'NUMBERED_LIST', '{"items": ["MARKETING_STRATEGY item 6a", "MARKETING_STRATEGY item 6b"]}'::jsonb, 6),



(257, 26, NULL, 'TODO', '{"items": ["MARKETING_STRATEGY item 7a", "MARKETING_STRATEGY item 7b"]}'::jsonb, 7),



(258, 26, NULL, 'TOGGLE', '{"text": "MARKETING_STRATEGY block 8 for document 26", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(259, 26, NULL, 'QUOTE', '{"text": "MARKETING_STRATEGY block 9 for document 26", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(260, 26, NULL, 'CALLOUT', '{"text": "MARKETING_STRATEGY block 10 for document 26", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(261, 27, NULL, 'TEXT', '{"text": "OTHER block 1 for document 27", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(262, 27, NULL, 'HEADING_1', '{"text": "OTHER heading 2"}'::jsonb, 2),



(263, 27, NULL, 'HEADING_2', '{"text": "OTHER heading 3"}'::jsonb, 3),



(264, 27, NULL, 'HEADING_3', '{"text": "OTHER heading 4"}'::jsonb, 4),



(265, 27, NULL, 'BULLETED_LIST', '{"items": ["OTHER item 5a", "OTHER item 5b"]}'::jsonb, 5),



(266, 27, NULL, 'NUMBERED_LIST', '{"items": ["OTHER item 6a", "OTHER item 6b"]}'::jsonb, 6),



(267, 27, NULL, 'TODO', '{"items": ["OTHER item 7a", "OTHER item 7b"]}'::jsonb, 7),



(268, 27, NULL, 'TOGGLE', '{"text": "OTHER block 8 for document 27", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(269, 27, NULL, 'QUOTE', '{"text": "OTHER block 9 for document 27", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(270, 27, NULL, 'CALLOUT', '{"text": "OTHER block 10 for document 27", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(271, 28, NULL, 'TEXT', '{"text": "TROUBLESHOOTING block 1 for document 28", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(272, 28, NULL, 'HEADING_1', '{"text": "TROUBLESHOOTING heading 2"}'::jsonb, 2),



(273, 28, NULL, 'HEADING_2', '{"text": "TROUBLESHOOTING heading 3"}'::jsonb, 3),



(274, 28, NULL, 'HEADING_3', '{"text": "TROUBLESHOOTING heading 4"}'::jsonb, 4),



(275, 28, NULL, 'BULLETED_LIST', '{"items": ["TROUBLESHOOTING item 5a", "TROUBLESHOOTING item 5b"]}'::jsonb, 5),



(276, 28, NULL, 'NUMBERED_LIST', '{"items": ["TROUBLESHOOTING item 6a", "TROUBLESHOOTING item 6b"]}'::jsonb, 6),



(277, 28, NULL, 'TODO', '{"items": ["TROUBLESHOOTING item 7a", "TROUBLESHOOTING item 7b"]}'::jsonb, 7),



(278, 28, NULL, 'TOGGLE', '{"text": "TROUBLESHOOTING block 8 for document 28", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(279, 28, NULL, 'QUOTE', '{"text": "TROUBLESHOOTING block 9 for document 28", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(280, 28, NULL, 'CALLOUT', '{"text": "TROUBLESHOOTING block 10 for document 28", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(281, 29, NULL, 'TEXT', '{"text": "ROLE block 1 for document 29", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(282, 29, NULL, 'HEADING_1', '{"text": "ROLE heading 2"}'::jsonb, 2),



(283, 29, NULL, 'HEADING_2', '{"text": "ROLE heading 3"}'::jsonb, 3),



(284, 29, NULL, 'HEADING_3', '{"text": "ROLE heading 4"}'::jsonb, 4),



(285, 29, NULL, 'BULLETED_LIST', '{"items": ["ROLE item 5a", "ROLE item 5b"]}'::jsonb, 5),



(286, 29, NULL, 'NUMBERED_LIST', '{"items": ["ROLE item 6a", "ROLE item 6b"]}'::jsonb, 6),



(287, 29, NULL, 'TODO', '{"items": ["ROLE item 7a", "ROLE item 7b"]}'::jsonb, 7),



(288, 29, NULL, 'TOGGLE', '{"text": "ROLE block 8 for document 29", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(289, 29, NULL, 'QUOTE', '{"text": "ROLE block 9 for document 29", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(290, 29, NULL, 'CALLOUT', '{"text": "ROLE block 10 for document 29", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(291, 30, NULL, 'TEXT', '{"text": "TECH_STACK block 1 for document 30", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(292, 30, NULL, 'HEADING_1', '{"text": "TECH_STACK heading 2"}'::jsonb, 2),



(293, 30, NULL, 'HEADING_2', '{"text": "TECH_STACK heading 3"}'::jsonb, 3),



(294, 30, NULL, 'HEADING_3', '{"text": "TECH_STACK heading 4"}'::jsonb, 4),



(295, 30, NULL, 'BULLETED_LIST', '{"items": ["TECH_STACK item 5a", "TECH_STACK item 5b"]}'::jsonb, 5),



(296, 30, NULL, 'NUMBERED_LIST', '{"items": ["TECH_STACK item 6a", "TECH_STACK item 6b"]}'::jsonb, 6),



(297, 30, NULL, 'TODO', '{"items": ["TECH_STACK item 7a", "TECH_STACK item 7b"]}'::jsonb, 7),



(298, 30, NULL, 'TOGGLE', '{"text": "TECH_STACK block 8 for document 30", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(299, 30, NULL, 'QUOTE', '{"text": "TECH_STACK block 9 for document 30", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(300, 30, NULL, 'CALLOUT', '{"text": "TECH_STACK block 10 for document 30", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10);



INSERT INTO blocks (id, document_id, parent_id, block_type, content, order_index) VALUES



(301, 31, NULL, 'TEXT', '{"text": "PROCESS block 1 for document 31", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(302, 31, NULL, 'HEADING_1', '{"text": "PROCESS heading 2"}'::jsonb, 2),



(303, 31, NULL, 'HEADING_2', '{"text": "PROCESS heading 3"}'::jsonb, 3),



(304, 31, NULL, 'HEADING_3', '{"text": "PROCESS heading 4"}'::jsonb, 4),



(305, 31, NULL, 'BULLETED_LIST', '{"items": ["PROCESS item 5a", "PROCESS item 5b"]}'::jsonb, 5),



(306, 31, NULL, 'NUMBERED_LIST', '{"items": ["PROCESS item 6a", "PROCESS item 6b"]}'::jsonb, 6),



(307, 31, NULL, 'TODO', '{"items": ["PROCESS item 7a", "PROCESS item 7b"]}'::jsonb, 7),



(308, 31, NULL, 'TOGGLE', '{"text": "PROCESS block 8 for document 31", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(309, 31, NULL, 'QUOTE', '{"text": "PROCESS block 9 for document 31", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(310, 31, NULL, 'CALLOUT', '{"text": "PROCESS block 10 for document 31", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(311, 32, NULL, 'TEXT', '{"text": "RESULT block 1 for document 32", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(312, 32, NULL, 'HEADING_1', '{"text": "RESULT heading 2"}'::jsonb, 2),



(313, 32, NULL, 'HEADING_2', '{"text": "RESULT heading 3"}'::jsonb, 3),



(314, 32, NULL, 'HEADING_3', '{"text": "RESULT heading 4"}'::jsonb, 4),



(315, 32, NULL, 'BULLETED_LIST', '{"items": ["RESULT item 5a", "RESULT item 5b"]}'::jsonb, 5),



(316, 32, NULL, 'NUMBERED_LIST', '{"items": ["RESULT item 6a", "RESULT item 6b"]}'::jsonb, 6),



(317, 32, NULL, 'TODO', '{"items": ["RESULT item 7a", "RESULT item 7b"]}'::jsonb, 7),



(318, 32, NULL, 'TOGGLE', '{"text": "RESULT block 8 for document 32", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(319, 32, NULL, 'QUOTE', '{"text": "RESULT block 9 for document 32", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(320, 32, NULL, 'CALLOUT', '{"text": "RESULT block 10 for document 32", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(321, 33, NULL, 'TEXT', '{"text": "RETROSPECTIVE block 1 for document 33", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(322, 33, NULL, 'HEADING_1', '{"text": "RETROSPECTIVE heading 2"}'::jsonb, 2),



(323, 33, NULL, 'HEADING_2', '{"text": "RETROSPECTIVE heading 3"}'::jsonb, 3),



(324, 33, NULL, 'HEADING_3', '{"text": "RETROSPECTIVE heading 4"}'::jsonb, 4),



(325, 33, NULL, 'BULLETED_LIST', '{"items": ["RETROSPECTIVE item 5a", "RETROSPECTIVE item 5b"]}'::jsonb, 5),



(326, 33, NULL, 'NUMBERED_LIST', '{"items": ["RETROSPECTIVE item 6a", "RETROSPECTIVE item 6b"]}'::jsonb, 6),



(327, 33, NULL, 'TODO', '{"items": ["RETROSPECTIVE item 7a", "RETROSPECTIVE item 7b"]}'::jsonb, 7),



(328, 33, NULL, 'TOGGLE', '{"text": "RETROSPECTIVE block 8 for document 33", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(329, 33, NULL, 'QUOTE', '{"text": "RETROSPECTIVE block 9 for document 33", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(330, 33, NULL, 'CALLOUT', '{"text": "RETROSPECTIVE block 10 for document 33", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(331, 34, NULL, 'TEXT', '{"text": "DESIGN_STORY block 1 for document 34", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(332, 34, NULL, 'HEADING_1', '{"text": "DESIGN_STORY heading 2"}'::jsonb, 2),



(333, 34, NULL, 'HEADING_2', '{"text": "DESIGN_STORY heading 3"}'::jsonb, 3),



(334, 34, NULL, 'HEADING_3', '{"text": "DESIGN_STORY heading 4"}'::jsonb, 4),



(335, 34, NULL, 'BULLETED_LIST', '{"items": ["DESIGN_STORY item 5a", "DESIGN_STORY item 5b"]}'::jsonb, 5),



(336, 34, NULL, 'NUMBERED_LIST', '{"items": ["DESIGN_STORY item 6a", "DESIGN_STORY item 6b"]}'::jsonb, 6),



(337, 34, NULL, 'TODO', '{"items": ["DESIGN_STORY item 7a", "DESIGN_STORY item 7b"]}'::jsonb, 7),



(338, 34, NULL, 'TOGGLE', '{"text": "DESIGN_STORY block 8 for document 34", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(339, 34, NULL, 'QUOTE', '{"text": "DESIGN_STORY block 9 for document 34", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(340, 34, NULL, 'CALLOUT', '{"text": "DESIGN_STORY block 10 for document 34", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(341, 35, NULL, 'TEXT', '{"text": "MARKETING_STRATEGY block 1 for document 35", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(342, 35, NULL, 'HEADING_1', '{"text": "MARKETING_STRATEGY heading 2"}'::jsonb, 2),



(343, 35, NULL, 'HEADING_2', '{"text": "MARKETING_STRATEGY heading 3"}'::jsonb, 3),



(344, 35, NULL, 'HEADING_3', '{"text": "MARKETING_STRATEGY heading 4"}'::jsonb, 4),



(345, 35, NULL, 'BULLETED_LIST', '{"items": ["MARKETING_STRATEGY item 5a", "MARKETING_STRATEGY item 5b"]}'::jsonb, 5),



(346, 35, NULL, 'NUMBERED_LIST', '{"items": ["MARKETING_STRATEGY item 6a", "MARKETING_STRATEGY item 6b"]}'::jsonb, 6),



(347, 35, NULL, 'TODO', '{"items": ["MARKETING_STRATEGY item 7a", "MARKETING_STRATEGY item 7b"]}'::jsonb, 7),



(348, 35, NULL, 'TOGGLE', '{"text": "MARKETING_STRATEGY block 8 for document 35", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(349, 35, NULL, 'QUOTE', '{"text": "MARKETING_STRATEGY block 9 for document 35", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(350, 35, NULL, 'CALLOUT', '{"text": "MARKETING_STRATEGY block 10 for document 35", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(351, 36, NULL, 'TEXT', '{"text": "OTHER block 1 for document 36", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(352, 36, NULL, 'HEADING_1', '{"text": "OTHER heading 2"}'::jsonb, 2),



(353, 36, NULL, 'HEADING_2', '{"text": "OTHER heading 3"}'::jsonb, 3),



(354, 36, NULL, 'HEADING_3', '{"text": "OTHER heading 4"}'::jsonb, 4),



(355, 36, NULL, 'BULLETED_LIST', '{"items": ["OTHER item 5a", "OTHER item 5b"]}'::jsonb, 5),



(356, 36, NULL, 'NUMBERED_LIST', '{"items": ["OTHER item 6a", "OTHER item 6b"]}'::jsonb, 6),



(357, 36, NULL, 'TODO', '{"items": ["OTHER item 7a", "OTHER item 7b"]}'::jsonb, 7),



(358, 36, NULL, 'TOGGLE', '{"text": "OTHER block 8 for document 36", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(359, 36, NULL, 'QUOTE', '{"text": "OTHER block 9 for document 36", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(360, 36, NULL, 'CALLOUT', '{"text": "OTHER block 10 for document 36", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(361, 37, NULL, 'TEXT', '{"text": "TROUBLESHOOTING block 1 for document 37", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(362, 37, NULL, 'HEADING_1', '{"text": "TROUBLESHOOTING heading 2"}'::jsonb, 2),



(363, 37, NULL, 'HEADING_2', '{"text": "TROUBLESHOOTING heading 3"}'::jsonb, 3),



(364, 37, NULL, 'HEADING_3', '{"text": "TROUBLESHOOTING heading 4"}'::jsonb, 4),



(365, 37, NULL, 'BULLETED_LIST', '{"items": ["TROUBLESHOOTING item 5a", "TROUBLESHOOTING item 5b"]}'::jsonb, 5),



(366, 37, NULL, 'NUMBERED_LIST', '{"items": ["TROUBLESHOOTING item 6a", "TROUBLESHOOTING item 6b"]}'::jsonb, 6),



(367, 37, NULL, 'TODO', '{"items": ["TROUBLESHOOTING item 7a", "TROUBLESHOOTING item 7b"]}'::jsonb, 7),



(368, 37, NULL, 'TOGGLE', '{"text": "TROUBLESHOOTING block 8 for document 37", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(369, 37, NULL, 'QUOTE', '{"text": "TROUBLESHOOTING block 9 for document 37", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(370, 37, NULL, 'CALLOUT', '{"text": "TROUBLESHOOTING block 10 for document 37", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(371, 38, NULL, 'TEXT', '{"text": "ROLE block 1 for document 38", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(372, 38, NULL, 'HEADING_1', '{"text": "ROLE heading 2"}'::jsonb, 2),



(373, 38, NULL, 'HEADING_2', '{"text": "ROLE heading 3"}'::jsonb, 3),



(374, 38, NULL, 'HEADING_3', '{"text": "ROLE heading 4"}'::jsonb, 4),



(375, 38, NULL, 'BULLETED_LIST', '{"items": ["ROLE item 5a", "ROLE item 5b"]}'::jsonb, 5),



(376, 38, NULL, 'NUMBERED_LIST', '{"items": ["ROLE item 6a", "ROLE item 6b"]}'::jsonb, 6),



(377, 38, NULL, 'TODO', '{"items": ["ROLE item 7a", "ROLE item 7b"]}'::jsonb, 7),



(378, 38, NULL, 'TOGGLE', '{"text": "ROLE block 8 for document 38", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(379, 38, NULL, 'QUOTE', '{"text": "ROLE block 9 for document 38", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(380, 38, NULL, 'CALLOUT', '{"text": "ROLE block 10 for document 38", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(381, 39, NULL, 'TEXT', '{"text": "TECH_STACK block 1 for document 39", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(382, 39, NULL, 'HEADING_1', '{"text": "TECH_STACK heading 2"}'::jsonb, 2),



(383, 39, NULL, 'HEADING_2', '{"text": "TECH_STACK heading 3"}'::jsonb, 3),



(384, 39, NULL, 'HEADING_3', '{"text": "TECH_STACK heading 4"}'::jsonb, 4),



(385, 39, NULL, 'BULLETED_LIST', '{"items": ["TECH_STACK item 5a", "TECH_STACK item 5b"]}'::jsonb, 5),



(386, 39, NULL, 'NUMBERED_LIST', '{"items": ["TECH_STACK item 6a", "TECH_STACK item 6b"]}'::jsonb, 6),



(387, 39, NULL, 'TODO', '{"items": ["TECH_STACK item 7a", "TECH_STACK item 7b"]}'::jsonb, 7),



(388, 39, NULL, 'TOGGLE', '{"text": "TECH_STACK block 8 for document 39", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(389, 39, NULL, 'QUOTE', '{"text": "TECH_STACK block 9 for document 39", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(390, 39, NULL, 'CALLOUT', '{"text": "TECH_STACK block 10 for document 39", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(391, 40, NULL, 'TEXT', '{"text": "PROCESS block 1 for document 40", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(392, 40, NULL, 'HEADING_1', '{"text": "PROCESS heading 2"}'::jsonb, 2),



(393, 40, NULL, 'HEADING_2', '{"text": "PROCESS heading 3"}'::jsonb, 3),



(394, 40, NULL, 'HEADING_3', '{"text": "PROCESS heading 4"}'::jsonb, 4),



(395, 40, NULL, 'BULLETED_LIST', '{"items": ["PROCESS item 5a", "PROCESS item 5b"]}'::jsonb, 5),



(396, 40, NULL, 'NUMBERED_LIST', '{"items": ["PROCESS item 6a", "PROCESS item 6b"]}'::jsonb, 6),



(397, 40, NULL, 'TODO', '{"items": ["PROCESS item 7a", "PROCESS item 7b"]}'::jsonb, 7),



(398, 40, NULL, 'TOGGLE', '{"text": "PROCESS block 8 for document 40", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(399, 40, NULL, 'QUOTE', '{"text": "PROCESS block 9 for document 40", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(400, 40, NULL, 'CALLOUT', '{"text": "PROCESS block 10 for document 40", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10);



INSERT INTO blocks (id, document_id, parent_id, block_type, content, order_index) VALUES



(401, 41, NULL, 'TEXT', '{"text": "RESULT block 1 for document 41", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(402, 41, NULL, 'HEADING_1', '{"text": "RESULT heading 2"}'::jsonb, 2),



(403, 41, NULL, 'HEADING_2', '{"text": "RESULT heading 3"}'::jsonb, 3),



(404, 41, NULL, 'HEADING_3', '{"text": "RESULT heading 4"}'::jsonb, 4),



(405, 41, NULL, 'BULLETED_LIST', '{"items": ["RESULT item 5a", "RESULT item 5b"]}'::jsonb, 5),



(406, 41, NULL, 'NUMBERED_LIST', '{"items": ["RESULT item 6a", "RESULT item 6b"]}'::jsonb, 6),



(407, 41, NULL, 'TODO', '{"items": ["RESULT item 7a", "RESULT item 7b"]}'::jsonb, 7),



(408, 41, NULL, 'TOGGLE', '{"text": "RESULT block 8 for document 41", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(409, 41, NULL, 'QUOTE', '{"text": "RESULT block 9 for document 41", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(410, 41, NULL, 'CALLOUT', '{"text": "RESULT block 10 for document 41", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(411, 42, NULL, 'TEXT', '{"text": "RETROSPECTIVE block 1 for document 42", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(412, 42, NULL, 'HEADING_1', '{"text": "RETROSPECTIVE heading 2"}'::jsonb, 2),



(413, 42, NULL, 'HEADING_2', '{"text": "RETROSPECTIVE heading 3"}'::jsonb, 3),



(414, 42, NULL, 'HEADING_3', '{"text": "RETROSPECTIVE heading 4"}'::jsonb, 4),



(415, 42, NULL, 'BULLETED_LIST', '{"items": ["RETROSPECTIVE item 5a", "RETROSPECTIVE item 5b"]}'::jsonb, 5),



(416, 42, NULL, 'NUMBERED_LIST', '{"items": ["RETROSPECTIVE item 6a", "RETROSPECTIVE item 6b"]}'::jsonb, 6),



(417, 42, NULL, 'TODO', '{"items": ["RETROSPECTIVE item 7a", "RETROSPECTIVE item 7b"]}'::jsonb, 7),



(418, 42, NULL, 'TOGGLE', '{"text": "RETROSPECTIVE block 8 for document 42", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(419, 42, NULL, 'QUOTE', '{"text": "RETROSPECTIVE block 9 for document 42", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(420, 42, NULL, 'CALLOUT', '{"text": "RETROSPECTIVE block 10 for document 42", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(421, 43, NULL, 'TEXT', '{"text": "DESIGN_STORY block 1 for document 43", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(422, 43, NULL, 'HEADING_1', '{"text": "DESIGN_STORY heading 2"}'::jsonb, 2),



(423, 43, NULL, 'HEADING_2', '{"text": "DESIGN_STORY heading 3"}'::jsonb, 3),



(424, 43, NULL, 'HEADING_3', '{"text": "DESIGN_STORY heading 4"}'::jsonb, 4),



(425, 43, NULL, 'BULLETED_LIST', '{"items": ["DESIGN_STORY item 5a", "DESIGN_STORY item 5b"]}'::jsonb, 5),



(426, 43, NULL, 'NUMBERED_LIST', '{"items": ["DESIGN_STORY item 6a", "DESIGN_STORY item 6b"]}'::jsonb, 6),



(427, 43, NULL, 'TODO', '{"items": ["DESIGN_STORY item 7a", "DESIGN_STORY item 7b"]}'::jsonb, 7),



(428, 43, NULL, 'TOGGLE', '{"text": "DESIGN_STORY block 8 for document 43", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(429, 43, NULL, 'QUOTE', '{"text": "DESIGN_STORY block 9 for document 43", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(430, 43, NULL, 'CALLOUT', '{"text": "DESIGN_STORY block 10 for document 43", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(431, 44, NULL, 'TEXT', '{"text": "MARKETING_STRATEGY block 1 for document 44", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(432, 44, NULL, 'HEADING_1', '{"text": "MARKETING_STRATEGY heading 2"}'::jsonb, 2),



(433, 44, NULL, 'HEADING_2', '{"text": "MARKETING_STRATEGY heading 3"}'::jsonb, 3),



(434, 44, NULL, 'HEADING_3', '{"text": "MARKETING_STRATEGY heading 4"}'::jsonb, 4),



(435, 44, NULL, 'BULLETED_LIST', '{"items": ["MARKETING_STRATEGY item 5a", "MARKETING_STRATEGY item 5b"]}'::jsonb, 5),



(436, 44, NULL, 'NUMBERED_LIST', '{"items": ["MARKETING_STRATEGY item 6a", "MARKETING_STRATEGY item 6b"]}'::jsonb, 6),



(437, 44, NULL, 'TODO', '{"items": ["MARKETING_STRATEGY item 7a", "MARKETING_STRATEGY item 7b"]}'::jsonb, 7),



(438, 44, NULL, 'TOGGLE', '{"text": "MARKETING_STRATEGY block 8 for document 44", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(439, 44, NULL, 'QUOTE', '{"text": "MARKETING_STRATEGY block 9 for document 44", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(440, 44, NULL, 'CALLOUT', '{"text": "MARKETING_STRATEGY block 10 for document 44", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(441, 45, NULL, 'TEXT', '{"text": "OTHER block 1 for document 45", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(442, 45, NULL, 'HEADING_1', '{"text": "OTHER heading 2"}'::jsonb, 2),



(443, 45, NULL, 'HEADING_2', '{"text": "OTHER heading 3"}'::jsonb, 3),



(444, 45, NULL, 'HEADING_3', '{"text": "OTHER heading 4"}'::jsonb, 4),



(445, 45, NULL, 'BULLETED_LIST', '{"items": ["OTHER item 5a", "OTHER item 5b"]}'::jsonb, 5),



(446, 45, NULL, 'NUMBERED_LIST', '{"items": ["OTHER item 6a", "OTHER item 6b"]}'::jsonb, 6),



(447, 45, NULL, 'TODO', '{"items": ["OTHER item 7a", "OTHER item 7b"]}'::jsonb, 7),



(448, 45, NULL, 'TOGGLE', '{"text": "OTHER block 8 for document 45", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(449, 45, NULL, 'QUOTE', '{"text": "OTHER block 9 for document 45", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(450, 45, NULL, 'CALLOUT', '{"text": "OTHER block 10 for document 45", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(451, 46, NULL, 'TEXT', '{"text": "TROUBLESHOOTING block 1 for document 46", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(452, 46, NULL, 'HEADING_1', '{"text": "TROUBLESHOOTING heading 2"}'::jsonb, 2),



(453, 46, NULL, 'HEADING_2', '{"text": "TROUBLESHOOTING heading 3"}'::jsonb, 3),



(454, 46, NULL, 'HEADING_3', '{"text": "TROUBLESHOOTING heading 4"}'::jsonb, 4),



(455, 46, NULL, 'BULLETED_LIST', '{"items": ["TROUBLESHOOTING item 5a", "TROUBLESHOOTING item 5b"]}'::jsonb, 5),



(456, 46, NULL, 'NUMBERED_LIST', '{"items": ["TROUBLESHOOTING item 6a", "TROUBLESHOOTING item 6b"]}'::jsonb, 6),



(457, 46, NULL, 'TODO', '{"items": ["TROUBLESHOOTING item 7a", "TROUBLESHOOTING item 7b"]}'::jsonb, 7),



(458, 46, NULL, 'TOGGLE', '{"text": "TROUBLESHOOTING block 8 for document 46", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(459, 46, NULL, 'QUOTE', '{"text": "TROUBLESHOOTING block 9 for document 46", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(460, 46, NULL, 'CALLOUT', '{"text": "TROUBLESHOOTING block 10 for document 46", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(461, 47, NULL, 'TEXT', '{"text": "ROLE block 1 for document 47", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(462, 47, NULL, 'HEADING_1', '{"text": "ROLE heading 2"}'::jsonb, 2),



(463, 47, NULL, 'HEADING_2', '{"text": "ROLE heading 3"}'::jsonb, 3),



(464, 47, NULL, 'HEADING_3', '{"text": "ROLE heading 4"}'::jsonb, 4),



(465, 47, NULL, 'BULLETED_LIST', '{"items": ["ROLE item 5a", "ROLE item 5b"]}'::jsonb, 5),



(466, 47, NULL, 'NUMBERED_LIST', '{"items": ["ROLE item 6a", "ROLE item 6b"]}'::jsonb, 6),



(467, 47, NULL, 'TODO', '{"items": ["ROLE item 7a", "ROLE item 7b"]}'::jsonb, 7),



(468, 47, NULL, 'TOGGLE', '{"text": "ROLE block 8 for document 47", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(469, 47, NULL, 'QUOTE', '{"text": "ROLE block 9 for document 47", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(470, 47, NULL, 'CALLOUT', '{"text": "ROLE block 10 for document 47", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(471, 48, NULL, 'TEXT', '{"text": "TECH_STACK block 1 for document 48", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(472, 48, NULL, 'HEADING_1', '{"text": "TECH_STACK heading 2"}'::jsonb, 2),



(473, 48, NULL, 'HEADING_2', '{"text": "TECH_STACK heading 3"}'::jsonb, 3),



(474, 48, NULL, 'HEADING_3', '{"text": "TECH_STACK heading 4"}'::jsonb, 4),



(475, 48, NULL, 'BULLETED_LIST', '{"items": ["TECH_STACK item 5a", "TECH_STACK item 5b"]}'::jsonb, 5),



(476, 48, NULL, 'NUMBERED_LIST', '{"items": ["TECH_STACK item 6a", "TECH_STACK item 6b"]}'::jsonb, 6),



(477, 48, NULL, 'TODO', '{"items": ["TECH_STACK item 7a", "TECH_STACK item 7b"]}'::jsonb, 7),



(478, 48, NULL, 'TOGGLE', '{"text": "TECH_STACK block 8 for document 48", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(479, 48, NULL, 'QUOTE', '{"text": "TECH_STACK block 9 for document 48", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(480, 48, NULL, 'CALLOUT', '{"text": "TECH_STACK block 10 for document 48", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(481, 49, NULL, 'TEXT', '{"text": "PROCESS block 1 for document 49", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(482, 49, NULL, 'HEADING_1', '{"text": "PROCESS heading 2"}'::jsonb, 2),



(483, 49, NULL, 'HEADING_2', '{"text": "PROCESS heading 3"}'::jsonb, 3),



(484, 49, NULL, 'HEADING_3', '{"text": "PROCESS heading 4"}'::jsonb, 4),



(485, 49, NULL, 'BULLETED_LIST', '{"items": ["PROCESS item 5a", "PROCESS item 5b"]}'::jsonb, 5),



(486, 49, NULL, 'NUMBERED_LIST', '{"items": ["PROCESS item 6a", "PROCESS item 6b"]}'::jsonb, 6),



(487, 49, NULL, 'TODO', '{"items": ["PROCESS item 7a", "PROCESS item 7b"]}'::jsonb, 7),



(488, 49, NULL, 'TOGGLE', '{"text": "PROCESS block 8 for document 49", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(489, 49, NULL, 'QUOTE', '{"text": "PROCESS block 9 for document 49", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(490, 49, NULL, 'CALLOUT', '{"text": "PROCESS block 10 for document 49", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(491, 50, NULL, 'TEXT', '{"text": "RESULT block 1 for document 50", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(492, 50, NULL, 'HEADING_1', '{"text": "RESULT heading 2"}'::jsonb, 2),



(493, 50, NULL, 'HEADING_2', '{"text": "RESULT heading 3"}'::jsonb, 3),



(494, 50, NULL, 'HEADING_3', '{"text": "RESULT heading 4"}'::jsonb, 4),



(495, 50, NULL, 'BULLETED_LIST', '{"items": ["RESULT item 5a", "RESULT item 5b"]}'::jsonb, 5),



(496, 50, NULL, 'NUMBERED_LIST', '{"items": ["RESULT item 6a", "RESULT item 6b"]}'::jsonb, 6),



(497, 50, NULL, 'TODO', '{"items": ["RESULT item 7a", "RESULT item 7b"]}'::jsonb, 7),



(498, 50, NULL, 'TOGGLE', '{"text": "RESULT block 8 for document 50", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(499, 50, NULL, 'QUOTE', '{"text": "RESULT block 9 for document 50", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(500, 50, NULL, 'CALLOUT', '{"text": "RESULT block 10 for document 50", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10);



INSERT INTO blocks (id, document_id, parent_id, block_type, content, order_index) VALUES



(501, 51, NULL, 'TEXT', '{"text": "RETROSPECTIVE block 1 for document 51", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(502, 51, NULL, 'HEADING_1', '{"text": "RETROSPECTIVE heading 2"}'::jsonb, 2),



(503, 51, NULL, 'HEADING_2', '{"text": "RETROSPECTIVE heading 3"}'::jsonb, 3),



(504, 51, NULL, 'HEADING_3', '{"text": "RETROSPECTIVE heading 4"}'::jsonb, 4),



(505, 51, NULL, 'BULLETED_LIST', '{"items": ["RETROSPECTIVE item 5a", "RETROSPECTIVE item 5b"]}'::jsonb, 5),



(506, 51, NULL, 'NUMBERED_LIST', '{"items": ["RETROSPECTIVE item 6a", "RETROSPECTIVE item 6b"]}'::jsonb, 6),



(507, 51, NULL, 'TODO', '{"items": ["RETROSPECTIVE item 7a", "RETROSPECTIVE item 7b"]}'::jsonb, 7),



(508, 51, NULL, 'TOGGLE', '{"text": "RETROSPECTIVE block 8 for document 51", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(509, 51, NULL, 'QUOTE', '{"text": "RETROSPECTIVE block 9 for document 51", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(510, 51, NULL, 'CALLOUT', '{"text": "RETROSPECTIVE block 10 for document 51", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(511, 52, NULL, 'TEXT', '{"text": "DESIGN_STORY block 1 for document 52", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(512, 52, NULL, 'HEADING_1', '{"text": "DESIGN_STORY heading 2"}'::jsonb, 2),



(513, 52, NULL, 'HEADING_2', '{"text": "DESIGN_STORY heading 3"}'::jsonb, 3),



(514, 52, NULL, 'HEADING_3', '{"text": "DESIGN_STORY heading 4"}'::jsonb, 4),



(515, 52, NULL, 'BULLETED_LIST', '{"items": ["DESIGN_STORY item 5a", "DESIGN_STORY item 5b"]}'::jsonb, 5),



(516, 52, NULL, 'NUMBERED_LIST', '{"items": ["DESIGN_STORY item 6a", "DESIGN_STORY item 6b"]}'::jsonb, 6),



(517, 52, NULL, 'TODO', '{"items": ["DESIGN_STORY item 7a", "DESIGN_STORY item 7b"]}'::jsonb, 7),



(518, 52, NULL, 'TOGGLE', '{"text": "DESIGN_STORY block 8 for document 52", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(519, 52, NULL, 'QUOTE', '{"text": "DESIGN_STORY block 9 for document 52", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(520, 52, NULL, 'CALLOUT', '{"text": "DESIGN_STORY block 10 for document 52", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(521, 53, NULL, 'TEXT', '{"text": "MARKETING_STRATEGY block 1 for document 53", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(522, 53, NULL, 'HEADING_1', '{"text": "MARKETING_STRATEGY heading 2"}'::jsonb, 2),



(523, 53, NULL, 'HEADING_2', '{"text": "MARKETING_STRATEGY heading 3"}'::jsonb, 3),



(524, 53, NULL, 'HEADING_3', '{"text": "MARKETING_STRATEGY heading 4"}'::jsonb, 4),



(525, 53, NULL, 'BULLETED_LIST', '{"items": ["MARKETING_STRATEGY item 5a", "MARKETING_STRATEGY item 5b"]}'::jsonb, 5),



(526, 53, NULL, 'NUMBERED_LIST', '{"items": ["MARKETING_STRATEGY item 6a", "MARKETING_STRATEGY item 6b"]}'::jsonb, 6),



(527, 53, NULL, 'TODO', '{"items": ["MARKETING_STRATEGY item 7a", "MARKETING_STRATEGY item 7b"]}'::jsonb, 7),



(528, 53, NULL, 'TOGGLE', '{"text": "MARKETING_STRATEGY block 8 for document 53", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(529, 53, NULL, 'QUOTE', '{"text": "MARKETING_STRATEGY block 9 for document 53", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(530, 53, NULL, 'CALLOUT', '{"text": "MARKETING_STRATEGY block 10 for document 53", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(531, 54, NULL, 'TEXT', '{"text": "OTHER block 1 for document 54", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(532, 54, NULL, 'HEADING_1', '{"text": "OTHER heading 2"}'::jsonb, 2),



(533, 54, NULL, 'HEADING_2', '{"text": "OTHER heading 3"}'::jsonb, 3),



(534, 54, NULL, 'HEADING_3', '{"text": "OTHER heading 4"}'::jsonb, 4),



(535, 54, NULL, 'BULLETED_LIST', '{"items": ["OTHER item 5a", "OTHER item 5b"]}'::jsonb, 5),



(536, 54, NULL, 'NUMBERED_LIST', '{"items": ["OTHER item 6a", "OTHER item 6b"]}'::jsonb, 6),



(537, 54, NULL, 'TODO', '{"items": ["OTHER item 7a", "OTHER item 7b"]}'::jsonb, 7),



(538, 54, NULL, 'TOGGLE', '{"text": "OTHER block 8 for document 54", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(539, 54, NULL, 'QUOTE', '{"text": "OTHER block 9 for document 54", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(540, 54, NULL, 'CALLOUT', '{"text": "OTHER block 10 for document 54", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(541, 55, NULL, 'TEXT', '{"text": "TROUBLESHOOTING block 1 for document 55", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(542, 55, NULL, 'HEADING_1', '{"text": "TROUBLESHOOTING heading 2"}'::jsonb, 2),



(543, 55, NULL, 'HEADING_2', '{"text": "TROUBLESHOOTING heading 3"}'::jsonb, 3),



(544, 55, NULL, 'HEADING_3', '{"text": "TROUBLESHOOTING heading 4"}'::jsonb, 4),



(545, 55, NULL, 'BULLETED_LIST', '{"items": ["TROUBLESHOOTING item 5a", "TROUBLESHOOTING item 5b"]}'::jsonb, 5),



(546, 55, NULL, 'NUMBERED_LIST', '{"items": ["TROUBLESHOOTING item 6a", "TROUBLESHOOTING item 6b"]}'::jsonb, 6),



(547, 55, NULL, 'TODO', '{"items": ["TROUBLESHOOTING item 7a", "TROUBLESHOOTING item 7b"]}'::jsonb, 7),



(548, 55, NULL, 'TOGGLE', '{"text": "TROUBLESHOOTING block 8 for document 55", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(549, 55, NULL, 'QUOTE', '{"text": "TROUBLESHOOTING block 9 for document 55", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(550, 55, NULL, 'CALLOUT', '{"text": "TROUBLESHOOTING block 10 for document 55", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(551, 56, NULL, 'TEXT', '{"text": "ROLE block 1 for document 56", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(552, 56, NULL, 'HEADING_1', '{"text": "ROLE heading 2"}'::jsonb, 2),



(553, 56, NULL, 'HEADING_2', '{"text": "ROLE heading 3"}'::jsonb, 3),



(554, 56, NULL, 'HEADING_3', '{"text": "ROLE heading 4"}'::jsonb, 4),



(555, 56, NULL, 'BULLETED_LIST', '{"items": ["ROLE item 5a", "ROLE item 5b"]}'::jsonb, 5),



(556, 56, NULL, 'NUMBERED_LIST', '{"items": ["ROLE item 6a", "ROLE item 6b"]}'::jsonb, 6),



(557, 56, NULL, 'TODO', '{"items": ["ROLE item 7a", "ROLE item 7b"]}'::jsonb, 7),



(558, 56, NULL, 'TOGGLE', '{"text": "ROLE block 8 for document 56", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(559, 56, NULL, 'QUOTE', '{"text": "ROLE block 9 for document 56", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(560, 56, NULL, 'CALLOUT', '{"text": "ROLE block 10 for document 56", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(561, 57, NULL, 'TEXT', '{"text": "TECH_STACK block 1 for document 57", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(562, 57, NULL, 'HEADING_1', '{"text": "TECH_STACK heading 2"}'::jsonb, 2),



(563, 57, NULL, 'HEADING_2', '{"text": "TECH_STACK heading 3"}'::jsonb, 3),



(564, 57, NULL, 'HEADING_3', '{"text": "TECH_STACK heading 4"}'::jsonb, 4),



(565, 57, NULL, 'BULLETED_LIST', '{"items": ["TECH_STACK item 5a", "TECH_STACK item 5b"]}'::jsonb, 5),



(566, 57, NULL, 'NUMBERED_LIST', '{"items": ["TECH_STACK item 6a", "TECH_STACK item 6b"]}'::jsonb, 6),



(567, 57, NULL, 'TODO', '{"items": ["TECH_STACK item 7a", "TECH_STACK item 7b"]}'::jsonb, 7),



(568, 57, NULL, 'TOGGLE', '{"text": "TECH_STACK block 8 for document 57", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(569, 57, NULL, 'QUOTE', '{"text": "TECH_STACK block 9 for document 57", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(570, 57, NULL, 'CALLOUT', '{"text": "TECH_STACK block 10 for document 57", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(571, 58, NULL, 'TEXT', '{"text": "PROCESS block 1 for document 58", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(572, 58, NULL, 'HEADING_1', '{"text": "PROCESS heading 2"}'::jsonb, 2),



(573, 58, NULL, 'HEADING_2', '{"text": "PROCESS heading 3"}'::jsonb, 3),



(574, 58, NULL, 'HEADING_3', '{"text": "PROCESS heading 4"}'::jsonb, 4),



(575, 58, NULL, 'BULLETED_LIST', '{"items": ["PROCESS item 5a", "PROCESS item 5b"]}'::jsonb, 5),



(576, 58, NULL, 'NUMBERED_LIST', '{"items": ["PROCESS item 6a", "PROCESS item 6b"]}'::jsonb, 6),



(577, 58, NULL, 'TODO', '{"items": ["PROCESS item 7a", "PROCESS item 7b"]}'::jsonb, 7),



(578, 58, NULL, 'TOGGLE', '{"text": "PROCESS block 8 for document 58", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(579, 58, NULL, 'QUOTE', '{"text": "PROCESS block 9 for document 58", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(580, 58, NULL, 'CALLOUT', '{"text": "PROCESS block 10 for document 58", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(581, 59, NULL, 'TEXT', '{"text": "RESULT block 1 for document 59", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(582, 59, NULL, 'HEADING_1', '{"text": "RESULT heading 2"}'::jsonb, 2),



(583, 59, NULL, 'HEADING_2', '{"text": "RESULT heading 3"}'::jsonb, 3),



(584, 59, NULL, 'HEADING_3', '{"text": "RESULT heading 4"}'::jsonb, 4),



(585, 59, NULL, 'BULLETED_LIST', '{"items": ["RESULT item 5a", "RESULT item 5b"]}'::jsonb, 5),



(586, 59, NULL, 'NUMBERED_LIST', '{"items": ["RESULT item 6a", "RESULT item 6b"]}'::jsonb, 6),



(587, 59, NULL, 'TODO', '{"items": ["RESULT item 7a", "RESULT item 7b"]}'::jsonb, 7),



(588, 59, NULL, 'TOGGLE', '{"text": "RESULT block 8 for document 59", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(589, 59, NULL, 'QUOTE', '{"text": "RESULT block 9 for document 59", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(590, 59, NULL, 'CALLOUT', '{"text": "RESULT block 10 for document 59", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(591, 60, NULL, 'TEXT', '{"text": "RETROSPECTIVE block 1 for document 60", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(592, 60, NULL, 'HEADING_1', '{"text": "RETROSPECTIVE heading 2"}'::jsonb, 2),



(593, 60, NULL, 'HEADING_2', '{"text": "RETROSPECTIVE heading 3"}'::jsonb, 3),



(594, 60, NULL, 'HEADING_3', '{"text": "RETROSPECTIVE heading 4"}'::jsonb, 4),



(595, 60, NULL, 'BULLETED_LIST', '{"items": ["RETROSPECTIVE item 5a", "RETROSPECTIVE item 5b"]}'::jsonb, 5),



(596, 60, NULL, 'NUMBERED_LIST', '{"items": ["RETROSPECTIVE item 6a", "RETROSPECTIVE item 6b"]}'::jsonb, 6),



(597, 60, NULL, 'TODO', '{"items": ["RETROSPECTIVE item 7a", "RETROSPECTIVE item 7b"]}'::jsonb, 7),



(598, 60, NULL, 'TOGGLE', '{"text": "RETROSPECTIVE block 8 for document 60", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(599, 60, NULL, 'QUOTE', '{"text": "RETROSPECTIVE block 9 for document 60", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(600, 60, NULL, 'CALLOUT', '{"text": "RETROSPECTIVE block 10 for document 60", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10);



INSERT INTO blocks (id, document_id, parent_id, block_type, content, order_index) VALUES



(601, 61, NULL, 'TEXT', '{"text": "DESIGN_STORY block 1 for document 61", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(602, 61, NULL, 'HEADING_1', '{"text": "DESIGN_STORY heading 2"}'::jsonb, 2),



(603, 61, NULL, 'HEADING_2', '{"text": "DESIGN_STORY heading 3"}'::jsonb, 3),



(604, 61, NULL, 'HEADING_3', '{"text": "DESIGN_STORY heading 4"}'::jsonb, 4),



(605, 61, NULL, 'BULLETED_LIST', '{"items": ["DESIGN_STORY item 5a", "DESIGN_STORY item 5b"]}'::jsonb, 5),



(606, 61, NULL, 'NUMBERED_LIST', '{"items": ["DESIGN_STORY item 6a", "DESIGN_STORY item 6b"]}'::jsonb, 6),



(607, 61, NULL, 'TODO', '{"items": ["DESIGN_STORY item 7a", "DESIGN_STORY item 7b"]}'::jsonb, 7),



(608, 61, NULL, 'TOGGLE', '{"text": "DESIGN_STORY block 8 for document 61", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(609, 61, NULL, 'QUOTE', '{"text": "DESIGN_STORY block 9 for document 61", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(610, 61, NULL, 'CALLOUT', '{"text": "DESIGN_STORY block 10 for document 61", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(611, 62, NULL, 'TEXT', '{"text": "MARKETING_STRATEGY block 1 for document 62", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(612, 62, NULL, 'HEADING_1', '{"text": "MARKETING_STRATEGY heading 2"}'::jsonb, 2),



(613, 62, NULL, 'HEADING_2', '{"text": "MARKETING_STRATEGY heading 3"}'::jsonb, 3),



(614, 62, NULL, 'HEADING_3', '{"text": "MARKETING_STRATEGY heading 4"}'::jsonb, 4),



(615, 62, NULL, 'BULLETED_LIST', '{"items": ["MARKETING_STRATEGY item 5a", "MARKETING_STRATEGY item 5b"]}'::jsonb, 5),



(616, 62, NULL, 'NUMBERED_LIST', '{"items": ["MARKETING_STRATEGY item 6a", "MARKETING_STRATEGY item 6b"]}'::jsonb, 6),



(617, 62, NULL, 'TODO', '{"items": ["MARKETING_STRATEGY item 7a", "MARKETING_STRATEGY item 7b"]}'::jsonb, 7),



(618, 62, NULL, 'TOGGLE', '{"text": "MARKETING_STRATEGY block 8 for document 62", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(619, 62, NULL, 'QUOTE', '{"text": "MARKETING_STRATEGY block 9 for document 62", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(620, 62, NULL, 'CALLOUT', '{"text": "MARKETING_STRATEGY block 10 for document 62", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(621, 63, NULL, 'TEXT', '{"text": "OTHER block 1 for document 63", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(622, 63, NULL, 'HEADING_1', '{"text": "OTHER heading 2"}'::jsonb, 2),



(623, 63, NULL, 'HEADING_2', '{"text": "OTHER heading 3"}'::jsonb, 3),



(624, 63, NULL, 'HEADING_3', '{"text": "OTHER heading 4"}'::jsonb, 4),



(625, 63, NULL, 'BULLETED_LIST', '{"items": ["OTHER item 5a", "OTHER item 5b"]}'::jsonb, 5),



(626, 63, NULL, 'NUMBERED_LIST', '{"items": ["OTHER item 6a", "OTHER item 6b"]}'::jsonb, 6),



(627, 63, NULL, 'TODO', '{"items": ["OTHER item 7a", "OTHER item 7b"]}'::jsonb, 7),



(628, 63, NULL, 'TOGGLE', '{"text": "OTHER block 8 for document 63", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(629, 63, NULL, 'QUOTE', '{"text": "OTHER block 9 for document 63", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(630, 63, NULL, 'CALLOUT', '{"text": "OTHER block 10 for document 63", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(631, 64, NULL, 'TEXT', '{"text": "TROUBLESHOOTING block 1 for document 64", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(632, 64, NULL, 'HEADING_1', '{"text": "TROUBLESHOOTING heading 2"}'::jsonb, 2),



(633, 64, NULL, 'HEADING_2', '{"text": "TROUBLESHOOTING heading 3"}'::jsonb, 3),



(634, 64, NULL, 'HEADING_3', '{"text": "TROUBLESHOOTING heading 4"}'::jsonb, 4),



(635, 64, NULL, 'BULLETED_LIST', '{"items": ["TROUBLESHOOTING item 5a", "TROUBLESHOOTING item 5b"]}'::jsonb, 5),



(636, 64, NULL, 'NUMBERED_LIST', '{"items": ["TROUBLESHOOTING item 6a", "TROUBLESHOOTING item 6b"]}'::jsonb, 6),



(637, 64, NULL, 'TODO', '{"items": ["TROUBLESHOOTING item 7a", "TROUBLESHOOTING item 7b"]}'::jsonb, 7),



(638, 64, NULL, 'TOGGLE', '{"text": "TROUBLESHOOTING block 8 for document 64", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(639, 64, NULL, 'QUOTE', '{"text": "TROUBLESHOOTING block 9 for document 64", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(640, 64, NULL, 'CALLOUT', '{"text": "TROUBLESHOOTING block 10 for document 64", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(641, 65, NULL, 'TEXT', '{"text": "ROLE block 1 for document 65", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(642, 65, NULL, 'HEADING_1', '{"text": "ROLE heading 2"}'::jsonb, 2),



(643, 65, NULL, 'HEADING_2', '{"text": "ROLE heading 3"}'::jsonb, 3),



(644, 65, NULL, 'HEADING_3', '{"text": "ROLE heading 4"}'::jsonb, 4),



(645, 65, NULL, 'BULLETED_LIST', '{"items": ["ROLE item 5a", "ROLE item 5b"]}'::jsonb, 5),



(646, 65, NULL, 'NUMBERED_LIST', '{"items": ["ROLE item 6a", "ROLE item 6b"]}'::jsonb, 6),



(647, 65, NULL, 'TODO', '{"items": ["ROLE item 7a", "ROLE item 7b"]}'::jsonb, 7),



(648, 65, NULL, 'TOGGLE', '{"text": "ROLE block 8 for document 65", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(649, 65, NULL, 'QUOTE', '{"text": "ROLE block 9 for document 65", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(650, 65, NULL, 'CALLOUT', '{"text": "ROLE block 10 for document 65", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(651, 66, NULL, 'TEXT', '{"text": "TECH_STACK block 1 for document 66", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(652, 66, NULL, 'HEADING_1', '{"text": "TECH_STACK heading 2"}'::jsonb, 2),



(653, 66, NULL, 'HEADING_2', '{"text": "TECH_STACK heading 3"}'::jsonb, 3),



(654, 66, NULL, 'HEADING_3', '{"text": "TECH_STACK heading 4"}'::jsonb, 4),



(655, 66, NULL, 'BULLETED_LIST', '{"items": ["TECH_STACK item 5a", "TECH_STACK item 5b"]}'::jsonb, 5),



(656, 66, NULL, 'NUMBERED_LIST', '{"items": ["TECH_STACK item 6a", "TECH_STACK item 6b"]}'::jsonb, 6),



(657, 66, NULL, 'TODO', '{"items": ["TECH_STACK item 7a", "TECH_STACK item 7b"]}'::jsonb, 7),



(658, 66, NULL, 'TOGGLE', '{"text": "TECH_STACK block 8 for document 66", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(659, 66, NULL, 'QUOTE', '{"text": "TECH_STACK block 9 for document 66", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(660, 66, NULL, 'CALLOUT', '{"text": "TECH_STACK block 10 for document 66", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(661, 67, NULL, 'TEXT', '{"text": "PROCESS block 1 for document 67", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(662, 67, NULL, 'HEADING_1', '{"text": "PROCESS heading 2"}'::jsonb, 2),



(663, 67, NULL, 'HEADING_2', '{"text": "PROCESS heading 3"}'::jsonb, 3),



(664, 67, NULL, 'HEADING_3', '{"text": "PROCESS heading 4"}'::jsonb, 4),



(665, 67, NULL, 'BULLETED_LIST', '{"items": ["PROCESS item 5a", "PROCESS item 5b"]}'::jsonb, 5),



(666, 67, NULL, 'NUMBERED_LIST', '{"items": ["PROCESS item 6a", "PROCESS item 6b"]}'::jsonb, 6),



(667, 67, NULL, 'TODO', '{"items": ["PROCESS item 7a", "PROCESS item 7b"]}'::jsonb, 7),



(668, 67, NULL, 'TOGGLE', '{"text": "PROCESS block 8 for document 67", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(669, 67, NULL, 'QUOTE', '{"text": "PROCESS block 9 for document 67", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(670, 67, NULL, 'CALLOUT', '{"text": "PROCESS block 10 for document 67", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(671, 68, NULL, 'TEXT', '{"text": "RESULT block 1 for document 68", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(672, 68, NULL, 'HEADING_1', '{"text": "RESULT heading 2"}'::jsonb, 2),



(673, 68, NULL, 'HEADING_2', '{"text": "RESULT heading 3"}'::jsonb, 3),



(674, 68, NULL, 'HEADING_3', '{"text": "RESULT heading 4"}'::jsonb, 4),



(675, 68, NULL, 'BULLETED_LIST', '{"items": ["RESULT item 5a", "RESULT item 5b"]}'::jsonb, 5),



(676, 68, NULL, 'NUMBERED_LIST', '{"items": ["RESULT item 6a", "RESULT item 6b"]}'::jsonb, 6),



(677, 68, NULL, 'TODO', '{"items": ["RESULT item 7a", "RESULT item 7b"]}'::jsonb, 7),



(678, 68, NULL, 'TOGGLE', '{"text": "RESULT block 8 for document 68", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(679, 68, NULL, 'QUOTE', '{"text": "RESULT block 9 for document 68", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(680, 68, NULL, 'CALLOUT', '{"text": "RESULT block 10 for document 68", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(681, 69, NULL, 'TEXT', '{"text": "RETROSPECTIVE block 1 for document 69", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(682, 69, NULL, 'HEADING_1', '{"text": "RETROSPECTIVE heading 2"}'::jsonb, 2),



(683, 69, NULL, 'HEADING_2', '{"text": "RETROSPECTIVE heading 3"}'::jsonb, 3),



(684, 69, NULL, 'HEADING_3', '{"text": "RETROSPECTIVE heading 4"}'::jsonb, 4),



(685, 69, NULL, 'BULLETED_LIST', '{"items": ["RETROSPECTIVE item 5a", "RETROSPECTIVE item 5b"]}'::jsonb, 5),



(686, 69, NULL, 'NUMBERED_LIST', '{"items": ["RETROSPECTIVE item 6a", "RETROSPECTIVE item 6b"]}'::jsonb, 6),



(687, 69, NULL, 'TODO', '{"items": ["RETROSPECTIVE item 7a", "RETROSPECTIVE item 7b"]}'::jsonb, 7),



(688, 69, NULL, 'TOGGLE', '{"text": "RETROSPECTIVE block 8 for document 69", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(689, 69, NULL, 'QUOTE', '{"text": "RETROSPECTIVE block 9 for document 69", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(690, 69, NULL, 'CALLOUT', '{"text": "RETROSPECTIVE block 10 for document 69", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(691, 70, NULL, 'TEXT', '{"text": "DESIGN_STORY block 1 for document 70", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(692, 70, NULL, 'HEADING_1', '{"text": "DESIGN_STORY heading 2"}'::jsonb, 2),



(693, 70, NULL, 'HEADING_2', '{"text": "DESIGN_STORY heading 3"}'::jsonb, 3),



(694, 70, NULL, 'HEADING_3', '{"text": "DESIGN_STORY heading 4"}'::jsonb, 4),



(695, 70, NULL, 'BULLETED_LIST', '{"items": ["DESIGN_STORY item 5a", "DESIGN_STORY item 5b"]}'::jsonb, 5),



(696, 70, NULL, 'NUMBERED_LIST', '{"items": ["DESIGN_STORY item 6a", "DESIGN_STORY item 6b"]}'::jsonb, 6),



(697, 70, NULL, 'TODO', '{"items": ["DESIGN_STORY item 7a", "DESIGN_STORY item 7b"]}'::jsonb, 7),



(698, 70, NULL, 'TOGGLE', '{"text": "DESIGN_STORY block 8 for document 70", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(699, 70, NULL, 'QUOTE', '{"text": "DESIGN_STORY block 9 for document 70", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(700, 70, NULL, 'CALLOUT', '{"text": "DESIGN_STORY block 10 for document 70", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10);



INSERT INTO blocks (id, document_id, parent_id, block_type, content, order_index) VALUES



(701, 71, NULL, 'TEXT', '{"text": "MARKETING_STRATEGY block 1 for document 71", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(702, 71, NULL, 'HEADING_1', '{"text": "MARKETING_STRATEGY heading 2"}'::jsonb, 2),



(703, 71, NULL, 'HEADING_2', '{"text": "MARKETING_STRATEGY heading 3"}'::jsonb, 3),



(704, 71, NULL, 'HEADING_3', '{"text": "MARKETING_STRATEGY heading 4"}'::jsonb, 4),



(705, 71, NULL, 'BULLETED_LIST', '{"items": ["MARKETING_STRATEGY item 5a", "MARKETING_STRATEGY item 5b"]}'::jsonb, 5),



(706, 71, NULL, 'NUMBERED_LIST', '{"items": ["MARKETING_STRATEGY item 6a", "MARKETING_STRATEGY item 6b"]}'::jsonb, 6),



(707, 71, NULL, 'TODO', '{"items": ["MARKETING_STRATEGY item 7a", "MARKETING_STRATEGY item 7b"]}'::jsonb, 7),



(708, 71, NULL, 'TOGGLE', '{"text": "MARKETING_STRATEGY block 8 for document 71", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(709, 71, NULL, 'QUOTE', '{"text": "MARKETING_STRATEGY block 9 for document 71", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(710, 71, NULL, 'CALLOUT', '{"text": "MARKETING_STRATEGY block 10 for document 71", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(711, 72, NULL, 'TEXT', '{"text": "OTHER block 1 for document 72", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(712, 72, NULL, 'HEADING_1', '{"text": "OTHER heading 2"}'::jsonb, 2),



(713, 72, NULL, 'HEADING_2', '{"text": "OTHER heading 3"}'::jsonb, 3),



(714, 72, NULL, 'HEADING_3', '{"text": "OTHER heading 4"}'::jsonb, 4),



(715, 72, NULL, 'BULLETED_LIST', '{"items": ["OTHER item 5a", "OTHER item 5b"]}'::jsonb, 5),



(716, 72, NULL, 'NUMBERED_LIST', '{"items": ["OTHER item 6a", "OTHER item 6b"]}'::jsonb, 6),



(717, 72, NULL, 'TODO', '{"items": ["OTHER item 7a", "OTHER item 7b"]}'::jsonb, 7),



(718, 72, NULL, 'TOGGLE', '{"text": "OTHER block 8 for document 72", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(719, 72, NULL, 'QUOTE', '{"text": "OTHER block 9 for document 72", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(720, 72, NULL, 'CALLOUT', '{"text": "OTHER block 10 for document 72", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(721, 73, NULL, 'TEXT', '{"text": "TROUBLESHOOTING block 1 for document 73", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(722, 73, NULL, 'HEADING_1', '{"text": "TROUBLESHOOTING heading 2"}'::jsonb, 2),



(723, 73, NULL, 'HEADING_2', '{"text": "TROUBLESHOOTING heading 3"}'::jsonb, 3),



(724, 73, NULL, 'HEADING_3', '{"text": "TROUBLESHOOTING heading 4"}'::jsonb, 4),



(725, 73, NULL, 'BULLETED_LIST', '{"items": ["TROUBLESHOOTING item 5a", "TROUBLESHOOTING item 5b"]}'::jsonb, 5),



(726, 73, NULL, 'NUMBERED_LIST', '{"items": ["TROUBLESHOOTING item 6a", "TROUBLESHOOTING item 6b"]}'::jsonb, 6),



(727, 73, NULL, 'TODO', '{"items": ["TROUBLESHOOTING item 7a", "TROUBLESHOOTING item 7b"]}'::jsonb, 7),



(728, 73, NULL, 'TOGGLE', '{"text": "TROUBLESHOOTING block 8 for document 73", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(729, 73, NULL, 'QUOTE', '{"text": "TROUBLESHOOTING block 9 for document 73", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(730, 73, NULL, 'CALLOUT', '{"text": "TROUBLESHOOTING block 10 for document 73", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(731, 74, NULL, 'TEXT', '{"text": "ROLE block 1 for document 74", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(732, 74, NULL, 'HEADING_1', '{"text": "ROLE heading 2"}'::jsonb, 2),



(733, 74, NULL, 'HEADING_2', '{"text": "ROLE heading 3"}'::jsonb, 3),



(734, 74, NULL, 'HEADING_3', '{"text": "ROLE heading 4"}'::jsonb, 4),



(735, 74, NULL, 'BULLETED_LIST', '{"items": ["ROLE item 5a", "ROLE item 5b"]}'::jsonb, 5),



(736, 74, NULL, 'NUMBERED_LIST', '{"items": ["ROLE item 6a", "ROLE item 6b"]}'::jsonb, 6),



(737, 74, NULL, 'TODO', '{"items": ["ROLE item 7a", "ROLE item 7b"]}'::jsonb, 7),



(738, 74, NULL, 'TOGGLE', '{"text": "ROLE block 8 for document 74", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(739, 74, NULL, 'QUOTE', '{"text": "ROLE block 9 for document 74", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(740, 74, NULL, 'CALLOUT', '{"text": "ROLE block 10 for document 74", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(741, 75, NULL, 'TEXT', '{"text": "TECH_STACK block 1 for document 75", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(742, 75, NULL, 'HEADING_1', '{"text": "TECH_STACK heading 2"}'::jsonb, 2),



(743, 75, NULL, 'HEADING_2', '{"text": "TECH_STACK heading 3"}'::jsonb, 3),



(744, 75, NULL, 'HEADING_3', '{"text": "TECH_STACK heading 4"}'::jsonb, 4),



(745, 75, NULL, 'BULLETED_LIST', '{"items": ["TECH_STACK item 5a", "TECH_STACK item 5b"]}'::jsonb, 5),



(746, 75, NULL, 'NUMBERED_LIST', '{"items": ["TECH_STACK item 6a", "TECH_STACK item 6b"]}'::jsonb, 6),



(747, 75, NULL, 'TODO', '{"items": ["TECH_STACK item 7a", "TECH_STACK item 7b"]}'::jsonb, 7),



(748, 75, NULL, 'TOGGLE', '{"text": "TECH_STACK block 8 for document 75", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(749, 75, NULL, 'QUOTE', '{"text": "TECH_STACK block 9 for document 75", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(750, 75, NULL, 'CALLOUT', '{"text": "TECH_STACK block 10 for document 75", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(751, 76, NULL, 'TEXT', '{"text": "PROCESS block 1 for document 76", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(752, 76, NULL, 'HEADING_1', '{"text": "PROCESS heading 2"}'::jsonb, 2),



(753, 76, NULL, 'HEADING_2', '{"text": "PROCESS heading 3"}'::jsonb, 3),



(754, 76, NULL, 'HEADING_3', '{"text": "PROCESS heading 4"}'::jsonb, 4),



(755, 76, NULL, 'BULLETED_LIST', '{"items": ["PROCESS item 5a", "PROCESS item 5b"]}'::jsonb, 5),



(756, 76, NULL, 'NUMBERED_LIST', '{"items": ["PROCESS item 6a", "PROCESS item 6b"]}'::jsonb, 6),



(757, 76, NULL, 'TODO', '{"items": ["PROCESS item 7a", "PROCESS item 7b"]}'::jsonb, 7),



(758, 76, NULL, 'TOGGLE', '{"text": "PROCESS block 8 for document 76", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(759, 76, NULL, 'QUOTE', '{"text": "PROCESS block 9 for document 76", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(760, 76, NULL, 'CALLOUT', '{"text": "PROCESS block 10 for document 76", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(761, 77, NULL, 'TEXT', '{"text": "RESULT block 1 for document 77", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(762, 77, NULL, 'HEADING_1', '{"text": "RESULT heading 2"}'::jsonb, 2),



(763, 77, NULL, 'HEADING_2', '{"text": "RESULT heading 3"}'::jsonb, 3),



(764, 77, NULL, 'HEADING_3', '{"text": "RESULT heading 4"}'::jsonb, 4),



(765, 77, NULL, 'BULLETED_LIST', '{"items": ["RESULT item 5a", "RESULT item 5b"]}'::jsonb, 5),



(766, 77, NULL, 'NUMBERED_LIST', '{"items": ["RESULT item 6a", "RESULT item 6b"]}'::jsonb, 6),



(767, 77, NULL, 'TODO', '{"items": ["RESULT item 7a", "RESULT item 7b"]}'::jsonb, 7),



(768, 77, NULL, 'TOGGLE', '{"text": "RESULT block 8 for document 77", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(769, 77, NULL, 'QUOTE', '{"text": "RESULT block 9 for document 77", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(770, 77, NULL, 'CALLOUT', '{"text": "RESULT block 10 for document 77", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(771, 78, NULL, 'TEXT', '{"text": "RETROSPECTIVE block 1 for document 78", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(772, 78, NULL, 'HEADING_1', '{"text": "RETROSPECTIVE heading 2"}'::jsonb, 2),



(773, 78, NULL, 'HEADING_2', '{"text": "RETROSPECTIVE heading 3"}'::jsonb, 3),



(774, 78, NULL, 'HEADING_3', '{"text": "RETROSPECTIVE heading 4"}'::jsonb, 4),



(775, 78, NULL, 'BULLETED_LIST', '{"items": ["RETROSPECTIVE item 5a", "RETROSPECTIVE item 5b"]}'::jsonb, 5),



(776, 78, NULL, 'NUMBERED_LIST', '{"items": ["RETROSPECTIVE item 6a", "RETROSPECTIVE item 6b"]}'::jsonb, 6),



(777, 78, NULL, 'TODO', '{"items": ["RETROSPECTIVE item 7a", "RETROSPECTIVE item 7b"]}'::jsonb, 7),



(778, 78, NULL, 'TOGGLE', '{"text": "RETROSPECTIVE block 8 for document 78", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(779, 78, NULL, 'QUOTE', '{"text": "RETROSPECTIVE block 9 for document 78", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(780, 78, NULL, 'CALLOUT', '{"text": "RETROSPECTIVE block 10 for document 78", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(781, 79, NULL, 'TEXT', '{"text": "DESIGN_STORY block 1 for document 79", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(782, 79, NULL, 'HEADING_1', '{"text": "DESIGN_STORY heading 2"}'::jsonb, 2),



(783, 79, NULL, 'HEADING_2', '{"text": "DESIGN_STORY heading 3"}'::jsonb, 3),



(784, 79, NULL, 'HEADING_3', '{"text": "DESIGN_STORY heading 4"}'::jsonb, 4),



(785, 79, NULL, 'BULLETED_LIST', '{"items": ["DESIGN_STORY item 5a", "DESIGN_STORY item 5b"]}'::jsonb, 5),



(786, 79, NULL, 'NUMBERED_LIST', '{"items": ["DESIGN_STORY item 6a", "DESIGN_STORY item 6b"]}'::jsonb, 6),



(787, 79, NULL, 'TODO', '{"items": ["DESIGN_STORY item 7a", "DESIGN_STORY item 7b"]}'::jsonb, 7),



(788, 79, NULL, 'TOGGLE', '{"text": "DESIGN_STORY block 8 for document 79", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(789, 79, NULL, 'QUOTE', '{"text": "DESIGN_STORY block 9 for document 79", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(790, 79, NULL, 'CALLOUT', '{"text": "DESIGN_STORY block 10 for document 79", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(791, 80, NULL, 'TEXT', '{"text": "MARKETING_STRATEGY block 1 for document 80", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(792, 80, NULL, 'HEADING_1', '{"text": "MARKETING_STRATEGY heading 2"}'::jsonb, 2),



(793, 80, NULL, 'HEADING_2', '{"text": "MARKETING_STRATEGY heading 3"}'::jsonb, 3),



(794, 80, NULL, 'HEADING_3', '{"text": "MARKETING_STRATEGY heading 4"}'::jsonb, 4),



(795, 80, NULL, 'BULLETED_LIST', '{"items": ["MARKETING_STRATEGY item 5a", "MARKETING_STRATEGY item 5b"]}'::jsonb, 5),



(796, 80, NULL, 'NUMBERED_LIST', '{"items": ["MARKETING_STRATEGY item 6a", "MARKETING_STRATEGY item 6b"]}'::jsonb, 6),



(797, 80, NULL, 'TODO', '{"items": ["MARKETING_STRATEGY item 7a", "MARKETING_STRATEGY item 7b"]}'::jsonb, 7),



(798, 80, NULL, 'TOGGLE', '{"text": "MARKETING_STRATEGY block 8 for document 80", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(799, 80, NULL, 'QUOTE', '{"text": "MARKETING_STRATEGY block 9 for document 80", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(800, 80, NULL, 'CALLOUT', '{"text": "MARKETING_STRATEGY block 10 for document 80", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10);



INSERT INTO blocks (id, document_id, parent_id, block_type, content, order_index) VALUES



(801, 81, NULL, 'TEXT', '{"text": "OTHER block 1 for document 81", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(802, 81, NULL, 'HEADING_1', '{"text": "OTHER heading 2"}'::jsonb, 2),



(803, 81, NULL, 'HEADING_2', '{"text": "OTHER heading 3"}'::jsonb, 3),



(804, 81, NULL, 'HEADING_3', '{"text": "OTHER heading 4"}'::jsonb, 4),



(805, 81, NULL, 'BULLETED_LIST', '{"items": ["OTHER item 5a", "OTHER item 5b"]}'::jsonb, 5),



(806, 81, NULL, 'NUMBERED_LIST', '{"items": ["OTHER item 6a", "OTHER item 6b"]}'::jsonb, 6),



(807, 81, NULL, 'TODO', '{"items": ["OTHER item 7a", "OTHER item 7b"]}'::jsonb, 7),



(808, 81, NULL, 'TOGGLE', '{"text": "OTHER block 8 for document 81", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(809, 81, NULL, 'QUOTE', '{"text": "OTHER block 9 for document 81", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(810, 81, NULL, 'CALLOUT', '{"text": "OTHER block 10 for document 81", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(811, 82, NULL, 'TEXT', '{"text": "TROUBLESHOOTING block 1 for document 82", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(812, 82, NULL, 'HEADING_1', '{"text": "TROUBLESHOOTING heading 2"}'::jsonb, 2),



(813, 82, NULL, 'HEADING_2', '{"text": "TROUBLESHOOTING heading 3"}'::jsonb, 3),



(814, 82, NULL, 'HEADING_3', '{"text": "TROUBLESHOOTING heading 4"}'::jsonb, 4),



(815, 82, NULL, 'BULLETED_LIST', '{"items": ["TROUBLESHOOTING item 5a", "TROUBLESHOOTING item 5b"]}'::jsonb, 5),



(816, 82, NULL, 'NUMBERED_LIST', '{"items": ["TROUBLESHOOTING item 6a", "TROUBLESHOOTING item 6b"]}'::jsonb, 6),



(817, 82, NULL, 'TODO', '{"items": ["TROUBLESHOOTING item 7a", "TROUBLESHOOTING item 7b"]}'::jsonb, 7),



(818, 82, NULL, 'TOGGLE', '{"text": "TROUBLESHOOTING block 8 for document 82", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(819, 82, NULL, 'QUOTE', '{"text": "TROUBLESHOOTING block 9 for document 82", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(820, 82, NULL, 'CALLOUT', '{"text": "TROUBLESHOOTING block 10 for document 82", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(821, 83, NULL, 'TEXT', '{"text": "ROLE block 1 for document 83", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(822, 83, NULL, 'HEADING_1', '{"text": "ROLE heading 2"}'::jsonb, 2),



(823, 83, NULL, 'HEADING_2', '{"text": "ROLE heading 3"}'::jsonb, 3),



(824, 83, NULL, 'HEADING_3', '{"text": "ROLE heading 4"}'::jsonb, 4),



(825, 83, NULL, 'BULLETED_LIST', '{"items": ["ROLE item 5a", "ROLE item 5b"]}'::jsonb, 5),



(826, 83, NULL, 'NUMBERED_LIST', '{"items": ["ROLE item 6a", "ROLE item 6b"]}'::jsonb, 6),



(827, 83, NULL, 'TODO', '{"items": ["ROLE item 7a", "ROLE item 7b"]}'::jsonb, 7),



(828, 83, NULL, 'TOGGLE', '{"text": "ROLE block 8 for document 83", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(829, 83, NULL, 'QUOTE', '{"text": "ROLE block 9 for document 83", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(830, 83, NULL, 'CALLOUT', '{"text": "ROLE block 10 for document 83", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(831, 84, NULL, 'TEXT', '{"text": "TECH_STACK block 1 for document 84", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(832, 84, NULL, 'HEADING_1', '{"text": "TECH_STACK heading 2"}'::jsonb, 2),



(833, 84, NULL, 'HEADING_2', '{"text": "TECH_STACK heading 3"}'::jsonb, 3),



(834, 84, NULL, 'HEADING_3', '{"text": "TECH_STACK heading 4"}'::jsonb, 4),



(835, 84, NULL, 'BULLETED_LIST', '{"items": ["TECH_STACK item 5a", "TECH_STACK item 5b"]}'::jsonb, 5),



(836, 84, NULL, 'NUMBERED_LIST', '{"items": ["TECH_STACK item 6a", "TECH_STACK item 6b"]}'::jsonb, 6),



(837, 84, NULL, 'TODO', '{"items": ["TECH_STACK item 7a", "TECH_STACK item 7b"]}'::jsonb, 7),



(838, 84, NULL, 'TOGGLE', '{"text": "TECH_STACK block 8 for document 84", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(839, 84, NULL, 'QUOTE', '{"text": "TECH_STACK block 9 for document 84", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(840, 84, NULL, 'CALLOUT', '{"text": "TECH_STACK block 10 for document 84", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(841, 85, NULL, 'TEXT', '{"text": "PROCESS block 1 for document 85", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(842, 85, NULL, 'HEADING_1', '{"text": "PROCESS heading 2"}'::jsonb, 2),



(843, 85, NULL, 'HEADING_2', '{"text": "PROCESS heading 3"}'::jsonb, 3),



(844, 85, NULL, 'HEADING_3', '{"text": "PROCESS heading 4"}'::jsonb, 4),



(845, 85, NULL, 'BULLETED_LIST', '{"items": ["PROCESS item 5a", "PROCESS item 5b"]}'::jsonb, 5),



(846, 85, NULL, 'NUMBERED_LIST', '{"items": ["PROCESS item 6a", "PROCESS item 6b"]}'::jsonb, 6),



(847, 85, NULL, 'TODO', '{"items": ["PROCESS item 7a", "PROCESS item 7b"]}'::jsonb, 7),



(848, 85, NULL, 'TOGGLE', '{"text": "PROCESS block 8 for document 85", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(849, 85, NULL, 'QUOTE', '{"text": "PROCESS block 9 for document 85", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(850, 85, NULL, 'CALLOUT', '{"text": "PROCESS block 10 for document 85", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(851, 86, NULL, 'TEXT', '{"text": "RESULT block 1 for document 86", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(852, 86, NULL, 'HEADING_1', '{"text": "RESULT heading 2"}'::jsonb, 2),



(853, 86, NULL, 'HEADING_2', '{"text": "RESULT heading 3"}'::jsonb, 3),



(854, 86, NULL, 'HEADING_3', '{"text": "RESULT heading 4"}'::jsonb, 4),



(855, 86, NULL, 'BULLETED_LIST', '{"items": ["RESULT item 5a", "RESULT item 5b"]}'::jsonb, 5),



(856, 86, NULL, 'NUMBERED_LIST', '{"items": ["RESULT item 6a", "RESULT item 6b"]}'::jsonb, 6),



(857, 86, NULL, 'TODO', '{"items": ["RESULT item 7a", "RESULT item 7b"]}'::jsonb, 7),



(858, 86, NULL, 'TOGGLE', '{"text": "RESULT block 8 for document 86", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(859, 86, NULL, 'QUOTE', '{"text": "RESULT block 9 for document 86", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(860, 86, NULL, 'CALLOUT', '{"text": "RESULT block 10 for document 86", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(861, 87, NULL, 'TEXT', '{"text": "RETROSPECTIVE block 1 for document 87", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(862, 87, NULL, 'HEADING_1', '{"text": "RETROSPECTIVE heading 2"}'::jsonb, 2),



(863, 87, NULL, 'HEADING_2', '{"text": "RETROSPECTIVE heading 3"}'::jsonb, 3),



(864, 87, NULL, 'HEADING_3', '{"text": "RETROSPECTIVE heading 4"}'::jsonb, 4),



(865, 87, NULL, 'BULLETED_LIST', '{"items": ["RETROSPECTIVE item 5a", "RETROSPECTIVE item 5b"]}'::jsonb, 5),



(866, 87, NULL, 'NUMBERED_LIST', '{"items": ["RETROSPECTIVE item 6a", "RETROSPECTIVE item 6b"]}'::jsonb, 6),



(867, 87, NULL, 'TODO', '{"items": ["RETROSPECTIVE item 7a", "RETROSPECTIVE item 7b"]}'::jsonb, 7),



(868, 87, NULL, 'TOGGLE', '{"text": "RETROSPECTIVE block 8 for document 87", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(869, 87, NULL, 'QUOTE', '{"text": "RETROSPECTIVE block 9 for document 87", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(870, 87, NULL, 'CALLOUT', '{"text": "RETROSPECTIVE block 10 for document 87", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(871, 88, NULL, 'TEXT', '{"text": "DESIGN_STORY block 1 for document 88", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(872, 88, NULL, 'HEADING_1', '{"text": "DESIGN_STORY heading 2"}'::jsonb, 2),



(873, 88, NULL, 'HEADING_2', '{"text": "DESIGN_STORY heading 3"}'::jsonb, 3),



(874, 88, NULL, 'HEADING_3', '{"text": "DESIGN_STORY heading 4"}'::jsonb, 4),



(875, 88, NULL, 'BULLETED_LIST', '{"items": ["DESIGN_STORY item 5a", "DESIGN_STORY item 5b"]}'::jsonb, 5),



(876, 88, NULL, 'NUMBERED_LIST', '{"items": ["DESIGN_STORY item 6a", "DESIGN_STORY item 6b"]}'::jsonb, 6),



(877, 88, NULL, 'TODO', '{"items": ["DESIGN_STORY item 7a", "DESIGN_STORY item 7b"]}'::jsonb, 7),



(878, 88, NULL, 'TOGGLE', '{"text": "DESIGN_STORY block 8 for document 88", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(879, 88, NULL, 'QUOTE', '{"text": "DESIGN_STORY block 9 for document 88", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(880, 88, NULL, 'CALLOUT', '{"text": "DESIGN_STORY block 10 for document 88", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(881, 89, NULL, 'TEXT', '{"text": "MARKETING_STRATEGY block 1 for document 89", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(882, 89, NULL, 'HEADING_1', '{"text": "MARKETING_STRATEGY heading 2"}'::jsonb, 2),



(883, 89, NULL, 'HEADING_2', '{"text": "MARKETING_STRATEGY heading 3"}'::jsonb, 3),



(884, 89, NULL, 'HEADING_3', '{"text": "MARKETING_STRATEGY heading 4"}'::jsonb, 4),



(885, 89, NULL, 'BULLETED_LIST', '{"items": ["MARKETING_STRATEGY item 5a", "MARKETING_STRATEGY item 5b"]}'::jsonb, 5),



(886, 89, NULL, 'NUMBERED_LIST', '{"items": ["MARKETING_STRATEGY item 6a", "MARKETING_STRATEGY item 6b"]}'::jsonb, 6),



(887, 89, NULL, 'TODO', '{"items": ["MARKETING_STRATEGY item 7a", "MARKETING_STRATEGY item 7b"]}'::jsonb, 7),



(888, 89, NULL, 'TOGGLE', '{"text": "MARKETING_STRATEGY block 8 for document 89", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(889, 89, NULL, 'QUOTE', '{"text": "MARKETING_STRATEGY block 9 for document 89", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(890, 89, NULL, 'CALLOUT', '{"text": "MARKETING_STRATEGY block 10 for document 89", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(891, 90, NULL, 'TEXT', '{"text": "OTHER block 1 for document 90", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(892, 90, NULL, 'HEADING_1', '{"text": "OTHER heading 2"}'::jsonb, 2),



(893, 90, NULL, 'HEADING_2', '{"text": "OTHER heading 3"}'::jsonb, 3),



(894, 90, NULL, 'HEADING_3', '{"text": "OTHER heading 4"}'::jsonb, 4),



(895, 90, NULL, 'BULLETED_LIST', '{"items": ["OTHER item 5a", "OTHER item 5b"]}'::jsonb, 5),



(896, 90, NULL, 'NUMBERED_LIST', '{"items": ["OTHER item 6a", "OTHER item 6b"]}'::jsonb, 6),



(897, 90, NULL, 'TODO', '{"items": ["OTHER item 7a", "OTHER item 7b"]}'::jsonb, 7),



(898, 90, NULL, 'TOGGLE', '{"text": "OTHER block 8 for document 90", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(899, 90, NULL, 'QUOTE', '{"text": "OTHER block 9 for document 90", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(900, 90, NULL, 'CALLOUT', '{"text": "OTHER block 10 for document 90", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10);



INSERT INTO blocks (id, document_id, parent_id, block_type, content, order_index) VALUES



(901, 91, NULL, 'TEXT', '{"text": "TROUBLESHOOTING block 1 for document 91", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(902, 91, NULL, 'HEADING_1', '{"text": "TROUBLESHOOTING heading 2"}'::jsonb, 2),



(903, 91, NULL, 'HEADING_2', '{"text": "TROUBLESHOOTING heading 3"}'::jsonb, 3),



(904, 91, NULL, 'HEADING_3', '{"text": "TROUBLESHOOTING heading 4"}'::jsonb, 4),



(905, 91, NULL, 'BULLETED_LIST', '{"items": ["TROUBLESHOOTING item 5a", "TROUBLESHOOTING item 5b"]}'::jsonb, 5),



(906, 91, NULL, 'NUMBERED_LIST', '{"items": ["TROUBLESHOOTING item 6a", "TROUBLESHOOTING item 6b"]}'::jsonb, 6),



(907, 91, NULL, 'TODO', '{"items": ["TROUBLESHOOTING item 7a", "TROUBLESHOOTING item 7b"]}'::jsonb, 7),



(908, 91, NULL, 'TOGGLE', '{"text": "TROUBLESHOOTING block 8 for document 91", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(909, 91, NULL, 'QUOTE', '{"text": "TROUBLESHOOTING block 9 for document 91", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(910, 91, NULL, 'CALLOUT', '{"text": "TROUBLESHOOTING block 10 for document 91", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(911, 92, NULL, 'TEXT', '{"text": "ROLE block 1 for document 92", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(912, 92, NULL, 'HEADING_1', '{"text": "ROLE heading 2"}'::jsonb, 2),



(913, 92, NULL, 'HEADING_2', '{"text": "ROLE heading 3"}'::jsonb, 3),



(914, 92, NULL, 'HEADING_3', '{"text": "ROLE heading 4"}'::jsonb, 4),



(915, 92, NULL, 'BULLETED_LIST', '{"items": ["ROLE item 5a", "ROLE item 5b"]}'::jsonb, 5),



(916, 92, NULL, 'NUMBERED_LIST', '{"items": ["ROLE item 6a", "ROLE item 6b"]}'::jsonb, 6),



(917, 92, NULL, 'TODO', '{"items": ["ROLE item 7a", "ROLE item 7b"]}'::jsonb, 7),



(918, 92, NULL, 'TOGGLE', '{"text": "ROLE block 8 for document 92", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(919, 92, NULL, 'QUOTE', '{"text": "ROLE block 9 for document 92", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(920, 92, NULL, 'CALLOUT', '{"text": "ROLE block 10 for document 92", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(921, 93, NULL, 'TEXT', '{"text": "TECH_STACK block 1 for document 93", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(922, 93, NULL, 'HEADING_1', '{"text": "TECH_STACK heading 2"}'::jsonb, 2),



(923, 93, NULL, 'HEADING_2', '{"text": "TECH_STACK heading 3"}'::jsonb, 3),



(924, 93, NULL, 'HEADING_3', '{"text": "TECH_STACK heading 4"}'::jsonb, 4),



(925, 93, NULL, 'BULLETED_LIST', '{"items": ["TECH_STACK item 5a", "TECH_STACK item 5b"]}'::jsonb, 5),



(926, 93, NULL, 'NUMBERED_LIST', '{"items": ["TECH_STACK item 6a", "TECH_STACK item 6b"]}'::jsonb, 6),



(927, 93, NULL, 'TODO', '{"items": ["TECH_STACK item 7a", "TECH_STACK item 7b"]}'::jsonb, 7),



(928, 93, NULL, 'TOGGLE', '{"text": "TECH_STACK block 8 for document 93", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(929, 93, NULL, 'QUOTE', '{"text": "TECH_STACK block 9 for document 93", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(930, 93, NULL, 'CALLOUT', '{"text": "TECH_STACK block 10 for document 93", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(931, 94, NULL, 'TEXT', '{"text": "PROCESS block 1 for document 94", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(932, 94, NULL, 'HEADING_1', '{"text": "PROCESS heading 2"}'::jsonb, 2),



(933, 94, NULL, 'HEADING_2', '{"text": "PROCESS heading 3"}'::jsonb, 3),



(934, 94, NULL, 'HEADING_3', '{"text": "PROCESS heading 4"}'::jsonb, 4),



(935, 94, NULL, 'BULLETED_LIST', '{"items": ["PROCESS item 5a", "PROCESS item 5b"]}'::jsonb, 5),



(936, 94, NULL, 'NUMBERED_LIST', '{"items": ["PROCESS item 6a", "PROCESS item 6b"]}'::jsonb, 6),



(937, 94, NULL, 'TODO', '{"items": ["PROCESS item 7a", "PROCESS item 7b"]}'::jsonb, 7),



(938, 94, NULL, 'TOGGLE', '{"text": "PROCESS block 8 for document 94", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(939, 94, NULL, 'QUOTE', '{"text": "PROCESS block 9 for document 94", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(940, 94, NULL, 'CALLOUT', '{"text": "PROCESS block 10 for document 94", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(941, 95, NULL, 'TEXT', '{"text": "RESULT block 1 for document 95", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(942, 95, NULL, 'HEADING_1', '{"text": "RESULT heading 2"}'::jsonb, 2),



(943, 95, NULL, 'HEADING_2', '{"text": "RESULT heading 3"}'::jsonb, 3),



(944, 95, NULL, 'HEADING_3', '{"text": "RESULT heading 4"}'::jsonb, 4),



(945, 95, NULL, 'BULLETED_LIST', '{"items": ["RESULT item 5a", "RESULT item 5b"]}'::jsonb, 5),



(946, 95, NULL, 'NUMBERED_LIST', '{"items": ["RESULT item 6a", "RESULT item 6b"]}'::jsonb, 6),



(947, 95, NULL, 'TODO', '{"items": ["RESULT item 7a", "RESULT item 7b"]}'::jsonb, 7),



(948, 95, NULL, 'TOGGLE', '{"text": "RESULT block 8 for document 95", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(949, 95, NULL, 'QUOTE', '{"text": "RESULT block 9 for document 95", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(950, 95, NULL, 'CALLOUT', '{"text": "RESULT block 10 for document 95", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(951, 96, NULL, 'TEXT', '{"text": "RETROSPECTIVE block 1 for document 96", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(952, 96, NULL, 'HEADING_1', '{"text": "RETROSPECTIVE heading 2"}'::jsonb, 2),



(953, 96, NULL, 'HEADING_2', '{"text": "RETROSPECTIVE heading 3"}'::jsonb, 3),



(954, 96, NULL, 'HEADING_3', '{"text": "RETROSPECTIVE heading 4"}'::jsonb, 4),



(955, 96, NULL, 'BULLETED_LIST', '{"items": ["RETROSPECTIVE item 5a", "RETROSPECTIVE item 5b"]}'::jsonb, 5),



(956, 96, NULL, 'NUMBERED_LIST', '{"items": ["RETROSPECTIVE item 6a", "RETROSPECTIVE item 6b"]}'::jsonb, 6),



(957, 96, NULL, 'TODO', '{"items": ["RETROSPECTIVE item 7a", "RETROSPECTIVE item 7b"]}'::jsonb, 7),



(958, 96, NULL, 'TOGGLE', '{"text": "RETROSPECTIVE block 8 for document 96", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(959, 96, NULL, 'QUOTE', '{"text": "RETROSPECTIVE block 9 for document 96", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(960, 96, NULL, 'CALLOUT', '{"text": "RETROSPECTIVE block 10 for document 96", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(961, 97, NULL, 'TEXT', '{"text": "DESIGN_STORY block 1 for document 97", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(962, 97, NULL, 'HEADING_1', '{"text": "DESIGN_STORY heading 2"}'::jsonb, 2),



(963, 97, NULL, 'HEADING_2', '{"text": "DESIGN_STORY heading 3"}'::jsonb, 3),



(964, 97, NULL, 'HEADING_3', '{"text": "DESIGN_STORY heading 4"}'::jsonb, 4),



(965, 97, NULL, 'BULLETED_LIST', '{"items": ["DESIGN_STORY item 5a", "DESIGN_STORY item 5b"]}'::jsonb, 5),



(966, 97, NULL, 'NUMBERED_LIST', '{"items": ["DESIGN_STORY item 6a", "DESIGN_STORY item 6b"]}'::jsonb, 6),



(967, 97, NULL, 'TODO', '{"items": ["DESIGN_STORY item 7a", "DESIGN_STORY item 7b"]}'::jsonb, 7),



(968, 97, NULL, 'TOGGLE', '{"text": "DESIGN_STORY block 8 for document 97", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(969, 97, NULL, 'QUOTE', '{"text": "DESIGN_STORY block 9 for document 97", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(970, 97, NULL, 'CALLOUT', '{"text": "DESIGN_STORY block 10 for document 97", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(971, 98, NULL, 'TEXT', '{"text": "MARKETING_STRATEGY block 1 for document 98", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(972, 98, NULL, 'HEADING_1', '{"text": "MARKETING_STRATEGY heading 2"}'::jsonb, 2),



(973, 98, NULL, 'HEADING_2', '{"text": "MARKETING_STRATEGY heading 3"}'::jsonb, 3),



(974, 98, NULL, 'HEADING_3', '{"text": "MARKETING_STRATEGY heading 4"}'::jsonb, 4),



(975, 98, NULL, 'BULLETED_LIST', '{"items": ["MARKETING_STRATEGY item 5a", "MARKETING_STRATEGY item 5b"]}'::jsonb, 5),



(976, 98, NULL, 'NUMBERED_LIST', '{"items": ["MARKETING_STRATEGY item 6a", "MARKETING_STRATEGY item 6b"]}'::jsonb, 6),



(977, 98, NULL, 'TODO', '{"items": ["MARKETING_STRATEGY item 7a", "MARKETING_STRATEGY item 7b"]}'::jsonb, 7),



(978, 98, NULL, 'TOGGLE', '{"text": "MARKETING_STRATEGY block 8 for document 98", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(979, 98, NULL, 'QUOTE', '{"text": "MARKETING_STRATEGY block 9 for document 98", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(980, 98, NULL, 'CALLOUT', '{"text": "MARKETING_STRATEGY block 10 for document 98", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(981, 99, NULL, 'TEXT', '{"text": "OTHER block 1 for document 99", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(982, 99, NULL, 'HEADING_1', '{"text": "OTHER heading 2"}'::jsonb, 2),



(983, 99, NULL, 'HEADING_2', '{"text": "OTHER heading 3"}'::jsonb, 3),



(984, 99, NULL, 'HEADING_3', '{"text": "OTHER heading 4"}'::jsonb, 4),



(985, 99, NULL, 'BULLETED_LIST', '{"items": ["OTHER item 5a", "OTHER item 5b"]}'::jsonb, 5),



(986, 99, NULL, 'NUMBERED_LIST', '{"items": ["OTHER item 6a", "OTHER item 6b"]}'::jsonb, 6),



(987, 99, NULL, 'TODO', '{"items": ["OTHER item 7a", "OTHER item 7b"]}'::jsonb, 7),



(988, 99, NULL, 'TOGGLE', '{"text": "OTHER block 8 for document 99", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(989, 99, NULL, 'QUOTE', '{"text": "OTHER block 9 for document 99", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(990, 99, NULL, 'CALLOUT', '{"text": "OTHER block 10 for document 99", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10),



(991, 100, NULL, 'TEXT', '{"text": "TROUBLESHOOTING block 1 for document 100", "index": 1, "tags": ["port", "demo"]}'::jsonb, 1),



(992, 100, NULL, 'HEADING_1', '{"text": "TROUBLESHOOTING heading 2"}'::jsonb, 2),



(993, 100, NULL, 'HEADING_2', '{"text": "TROUBLESHOOTING heading 3"}'::jsonb, 3),



(994, 100, NULL, 'HEADING_3', '{"text": "TROUBLESHOOTING heading 4"}'::jsonb, 4),



(995, 100, NULL, 'BULLETED_LIST', '{"items": ["TROUBLESHOOTING item 5a", "TROUBLESHOOTING item 5b"]}'::jsonb, 5),



(996, 100, NULL, 'NUMBERED_LIST', '{"items": ["TROUBLESHOOTING item 6a", "TROUBLESHOOTING item 6b"]}'::jsonb, 6),



(997, 100, NULL, 'TODO', '{"items": ["TROUBLESHOOTING item 7a", "TROUBLESHOOTING item 7b"]}'::jsonb, 7),



(998, 100, NULL, 'TOGGLE', '{"text": "TROUBLESHOOTING block 8 for document 100", "index": 8, "tags": ["port", "demo"]}'::jsonb, 8),



(999, 100, NULL, 'QUOTE', '{"text": "TROUBLESHOOTING block 9 for document 100", "index": 9, "tags": ["port", "demo"]}'::jsonb, 9),



(1000, 100, NULL, 'CALLOUT', '{"text": "TROUBLESHOOTING block 10 for document 100", "index": 10, "tags": ["port", "demo"]}'::jsonb, 10);







INSERT INTO messages (id, sender_id, receiver_id, content, is_read, read_at) VALUES



(1, 1, 2, '요청하단 설명이에 각인을 더 추가해주세요.', FALSE, NULL),



(2, 2, 3, '이 문서의 사용자 흐름이 지금보다 더 짧게 보이면 좋습니다.', FALSE, NULL),



(3, 3, 4, '주요 포인트만 전달하면 코멘트로 접재도 쉬워집니다.', TRUE, '2026-06-04 09:30:00'),



(4, 4, 5, '이슈 정리에서 중복가 접입제에서 적어주면 좋고습니다.', FALSE, NULL),



(5, 5, 6, '추가 설명이 필요하면 스크립스타일을 통일해주세요.', FALSE, NULL),



(6, 6, 7, '요청하단 설명이에 각인을 더 추가해주세요.', TRUE, '2026-06-07 09:30:00'),



(7, 7, 8, '이 문서의 사용자 흐름이 지금보다 더 짧게 보이면 좋습니다.', FALSE, NULL),



(8, 8, 9, '주요 포인트만 전달하면 코멘트로 접재도 쉬워집니다.', FALSE, NULL),



(9, 9, 10, '이슈 정리에서 중복가 접입제에서 적어주면 좋고습니다.', TRUE, '2026-06-10 09:30:00'),



(10, 10, 11, '추가 설명이 필요하면 스크립스타일을 통일해주세요.', FALSE, NULL),



(11, 11, 12, '요청하단 설명이에 각인을 더 추가해주세요.', FALSE, NULL),



(12, 12, 13, '이 문서의 사용자 흐름이 지금보다 더 짧게 보이면 좋습니다.', TRUE, '2026-06-13 09:30:00'),



(13, 13, 14, '주요 포인트만 전달하면 코멘트로 접재도 쉬워집니다.', FALSE, NULL),



(14, 14, 15, '이슈 정리에서 중복가 접입제에서 적어주면 좋고습니다.', FALSE, NULL),



(15, 15, 16, '추가 설명이 필요하면 스크립스타일을 통일해주세요.', TRUE, '2026-06-16 09:30:00'),



(16, 16, 17, '요청하단 설명이에 각인을 더 추가해주세요.', FALSE, NULL),



(17, 17, 18, '이 문서의 사용자 흐름이 지금보다 더 짧게 보이면 좋습니다.', FALSE, NULL),



(18, 18, 19, '주요 포인트만 전달하면 코멘트로 접재도 쉬워집니다.', TRUE, '2026-06-19 09:30:00'),



(19, 19, 20, '이슈 정리에서 중복가 접입제에서 적어주면 좋고습니다.', FALSE, NULL),



(20, 20, 21, '추가 설명이 필요하면 스크립스타일을 통일해주세요.', FALSE, NULL),



(21, 21, 22, '요청하단 설명이에 각인을 더 추가해주세요.', TRUE, '2026-06-22 09:30:00'),



(22, 22, 23, '이 문서의 사용자 흐름이 지금보다 더 짧게 보이면 좋습니다.', FALSE, NULL),



(23, 23, 24, '주요 포인트만 전달하면 코멘트로 접재도 쉬워집니다.', FALSE, NULL),



(24, 24, 25, '이슈 정리에서 중복가 접입제에서 적어주면 좋고습니다.', TRUE, '2026-06-25 09:30:00'),



(25, 25, 26, '추가 설명이 필요하면 스크립스타일을 통일해주세요.', FALSE, NULL),



(26, 26, 27, '요청하단 설명이에 각인을 더 추가해주세요.', FALSE, NULL),



(27, 27, 28, '이 문서의 사용자 흐름이 지금보다 더 짧게 보이면 좋습니다.', TRUE, '2026-06-28 09:30:00'),



(28, 28, 29, '주요 포인트만 전달하면 코멘트로 접재도 쉬워집니다.', FALSE, NULL),



(29, 29, 30, '이슈 정리에서 중복가 접입제에서 적어주면 좋고습니다.', FALSE, NULL),



(30, 30, 1, '추가 설명이 필요하면 스크립스타일을 통일해주세요.', TRUE, '2026-06-03 09:30:00'),



(31, 1, 2, '요청하단 설명이에 각인을 더 추가해주세요.', FALSE, NULL),



(32, 2, 3, '이 문서의 사용자 흐름이 지금보다 더 짧게 보이면 좋습니다.', FALSE, NULL),



(33, 3, 4, '주요 포인트만 전달하면 코멘트로 접재도 쉬워집니다.', TRUE, '2026-06-06 09:30:00'),



(34, 4, 5, '이슈 정리에서 중복가 접입제에서 적어주면 좋고습니다.', FALSE, NULL),



(35, 5, 6, '추가 설명이 필요하면 스크립스타일을 통일해주세요.', FALSE, NULL),



(36, 6, 7, '요청하단 설명이에 각인을 더 추가해주세요.', TRUE, '2026-06-09 09:30:00'),



(37, 7, 8, '이 문서의 사용자 흐름이 지금보다 더 짧게 보이면 좋습니다.', FALSE, NULL),



(38, 8, 9, '주요 포인트만 전달하면 코멘트로 접재도 쉬워집니다.', FALSE, NULL),



(39, 9, 10, '이슈 정리에서 중복가 접입제에서 적어주면 좋고습니다.', TRUE, '2026-06-12 09:30:00'),



(40, 10, 11, '추가 설명이 필요하면 스크립스타일을 통일해주세요.', FALSE, NULL),



(41, 11, 12, '요청하단 설명이에 각인을 더 추가해주세요.', FALSE, NULL),



(42, 12, 13, '이 문서의 사용자 흐름이 지금보다 더 짧게 보이면 좋습니다.', TRUE, '2026-06-15 09:30:00'),



(43, 13, 14, '주요 포인트만 전달하면 코멘트로 접재도 쉬워집니다.', FALSE, NULL),



(44, 14, 15, '이슈 정리에서 중복가 접입제에서 적어주면 좋고습니다.', FALSE, NULL),



(45, 15, 16, '추가 설명이 필요하면 스크립스타일을 통일해주세요.', TRUE, '2026-06-18 09:30:00'),



(46, 16, 17, '요청하단 설명이에 각인을 더 추가해주세요.', FALSE, NULL),



(47, 17, 18, '이 문서의 사용자 흐름이 지금보다 더 짧게 보이면 좋습니다.', FALSE, NULL),



(48, 18, 19, '주요 포인트만 전달하면 코멘트로 접재도 쉬워집니다.', TRUE, '2026-06-21 09:30:00'),



(49, 19, 20, '이슈 정리에서 중복가 접입제에서 적어주면 좋고습니다.', FALSE, NULL),



(50, 20, 21, '추가 설명이 필요하면 스크립스타일을 통일해주세요.', FALSE, NULL),



(51, 21, 22, '요청하단 설명이에 각인을 더 추가해주세요.', TRUE, '2026-06-24 09:30:00'),



(52, 22, 23, '이 문서의 사용자 흐름이 지금보다 더 짧게 보이면 좋습니다.', FALSE, NULL),



(53, 23, 24, '주요 포인트만 전달하면 코멘트로 접재도 쉬워집니다.', FALSE, NULL),



(54, 24, 25, '이슈 정리에서 중복가 접입제에서 적어주면 좋고습니다.', TRUE, '2026-06-27 09:30:00'),



(55, 25, 26, '추가 설명이 필요하면 스크립스타일을 통일해주세요.', FALSE, NULL),



(56, 26, 27, '요청하단 설명이에 각인을 더 추가해주세요.', FALSE, NULL),



(57, 27, 28, '이 문서의 사용자 흐름이 지금보다 더 짧게 보이면 좋습니다.', TRUE, '2026-06-02 09:30:00'),



(58, 28, 29, '주요 포인트만 전달하면 코멘트로 접재도 쉬워집니다.', FALSE, NULL),



(59, 29, 30, '이슈 정리에서 중복가 접입제에서 적어주면 좋고습니다.', FALSE, NULL),



(60, 30, 1, '추가 설명이 필요하면 스크립스타일을 통일해주세요.', TRUE, '2026-06-05 09:30:00'),



(61, 1, 2, '요청하단 설명이에 각인을 더 추가해주세요.', FALSE, NULL),



(62, 2, 3, '이 문서의 사용자 흐름이 지금보다 더 짧게 보이면 좋습니다.', FALSE, NULL),



(63, 3, 4, '주요 포인트만 전달하면 코멘트로 접재도 쉬워집니다.', TRUE, '2026-06-08 09:30:00'),



(64, 4, 5, '이슈 정리에서 중복가 접입제에서 적어주면 좋고습니다.', FALSE, NULL),



(65, 5, 6, '추가 설명이 필요하면 스크립스타일을 통일해주세요.', FALSE, NULL),



(66, 6, 7, '요청하단 설명이에 각인을 더 추가해주세요.', TRUE, '2026-06-11 09:30:00'),



(67, 7, 8, '이 문서의 사용자 흐름이 지금보다 더 짧게 보이면 좋습니다.', FALSE, NULL),



(68, 8, 9, '주요 포인트만 전달하면 코멘트로 접재도 쉬워집니다.', FALSE, NULL),



(69, 9, 10, '이슈 정리에서 중복가 접입제에서 적어주면 좋고습니다.', TRUE, '2026-06-14 09:30:00'),



(70, 10, 11, '추가 설명이 필요하면 스크립스타일을 통일해주세요.', FALSE, NULL),



(71, 11, 12, '요청하단 설명이에 각인을 더 추가해주세요.', FALSE, NULL),



(72, 12, 13, '이 문서의 사용자 흐름이 지금보다 더 짧게 보이면 좋습니다.', TRUE, '2026-06-17 09:30:00'),



(73, 13, 14, '주요 포인트만 전달하면 코멘트로 접재도 쉬워집니다.', FALSE, NULL),



(74, 14, 15, '이슈 정리에서 중복가 접입제에서 적어주면 좋고습니다.', FALSE, NULL),



(75, 15, 16, '추가 설명이 필요하면 스크립스타일을 통일해주세요.', TRUE, '2026-06-20 09:30:00'),



(76, 16, 17, '요청하단 설명이에 각인을 더 추가해주세요.', FALSE, NULL),



(77, 17, 18, '이 문서의 사용자 흐름이 지금보다 더 짧게 보이면 좋습니다.', FALSE, NULL),



(78, 18, 19, '주요 포인트만 전달하면 코멘트로 접재도 쉬워집니다.', TRUE, '2026-06-23 09:30:00'),



(79, 19, 20, '이슈 정리에서 중복가 접입제에서 적어주면 좋고습니다.', FALSE, NULL),



(80, 20, 21, '추가 설명이 필요하면 스크립스타일을 통일해주세요.', FALSE, NULL),



(81, 21, 22, '요청하단 설명이에 각인을 더 추가해주세요.', TRUE, '2026-06-26 09:30:00'),



(82, 22, 23, '이 문서의 사용자 흐름이 지금보다 더 짧게 보이면 좋습니다.', FALSE, NULL),



(83, 23, 24, '주요 포인트만 전달하면 코멘트로 접재도 쉬워집니다.', FALSE, NULL),



(84, 24, 25, '이슈 정리에서 중복가 접입제에서 적어주면 좋고습니다.', TRUE, '2026-06-01 09:30:00'),



(85, 25, 26, '추가 설명이 필요하면 스크립스타일을 통일해주세요.', FALSE, NULL),



(86, 26, 27, '요청하단 설명이에 각인을 더 추가해주세요.', FALSE, NULL),



(87, 27, 28, '이 문서의 사용자 흐름이 지금보다 더 짧게 보이면 좋습니다.', TRUE, '2026-06-04 09:30:00'),



(88, 28, 29, '주요 포인트만 전달하면 코멘트로 접재도 쉬워집니다.', FALSE, NULL),



(89, 29, 30, '이슈 정리에서 중복가 접입제에서 적어주면 좋고습니다.', FALSE, NULL),



(90, 30, 1, '추가 설명이 필요하면 스크립스타일을 통일해주세요.', TRUE, '2026-06-07 09:30:00'),



(91, 1, 2, '요청하단 설명이에 각인을 더 추가해주세요.', FALSE, NULL),



(92, 2, 3, '이 문서의 사용자 흐름이 지금보다 더 짧게 보이면 좋습니다.', FALSE, NULL),



(93, 3, 4, '주요 포인트만 전달하면 코멘트로 접재도 쉬워집니다.', TRUE, '2026-06-10 09:30:00'),



(94, 4, 5, '이슈 정리에서 중복가 접입제에서 적어주면 좋고습니다.', FALSE, NULL),



(95, 5, 6, '추가 설명이 필요하면 스크립스타일을 통일해주세요.', FALSE, NULL),



(96, 6, 7, '요청하단 설명이에 각인을 더 추가해주세요.', TRUE, '2026-06-13 09:30:00'),



(97, 7, 8, '이 문서의 사용자 흐름이 지금보다 더 짧게 보이면 좋습니다.', FALSE, NULL),



(98, 8, 9, '주요 포인트만 전달하면 코멘트로 접재도 쉬워집니다.', FALSE, NULL),



(99, 9, 10, '이슈 정리에서 중복가 접입제에서 적어주면 좋고습니다.', TRUE, '2026-06-16 09:30:00'),



(100, 10, 11, '추가 설명이 필요하면 스크립스타일을 통일해주세요.', FALSE, NULL);



INSERT INTO messages (id, sender_id, receiver_id, content, is_read, read_at) VALUES



(101, 11, 12, '요청하단 설명이에 각인을 더 추가해주세요.', FALSE, NULL),



(102, 12, 13, '이 문서의 사용자 흐름이 지금보다 더 짧게 보이면 좋습니다.', TRUE, '2026-06-19 09:30:00'),



(103, 13, 14, '주요 포인트만 전달하면 코멘트로 접재도 쉬워집니다.', FALSE, NULL),



(104, 14, 15, '이슈 정리에서 중복가 접입제에서 적어주면 좋고습니다.', FALSE, NULL),



(105, 15, 16, '추가 설명이 필요하면 스크립스타일을 통일해주세요.', TRUE, '2026-06-22 09:30:00'),



(106, 16, 17, '요청하단 설명이에 각인을 더 추가해주세요.', FALSE, NULL),



(107, 17, 18, '이 문서의 사용자 흐름이 지금보다 더 짧게 보이면 좋습니다.', FALSE, NULL),



(108, 18, 19, '주요 포인트만 전달하면 코멘트로 접재도 쉬워집니다.', TRUE, '2026-06-25 09:30:00'),



(109, 19, 20, '이슈 정리에서 중복가 접입제에서 적어주면 좋고습니다.', FALSE, NULL),



(110, 20, 21, '추가 설명이 필요하면 스크립스타일을 통일해주세요.', FALSE, NULL),



(111, 21, 22, '요청하단 설명이에 각인을 더 추가해주세요.', TRUE, '2026-06-28 09:30:00'),



(112, 22, 23, '이 문서의 사용자 흐름이 지금보다 더 짧게 보이면 좋습니다.', FALSE, NULL),



(113, 23, 24, '주요 포인트만 전달하면 코멘트로 접재도 쉬워집니다.', FALSE, NULL),



(114, 24, 25, '이슈 정리에서 중복가 접입제에서 적어주면 좋고습니다.', TRUE, '2026-06-03 09:30:00'),



(115, 25, 26, '추가 설명이 필요하면 스크립스타일을 통일해주세요.', FALSE, NULL),



(116, 26, 27, '요청하단 설명이에 각인을 더 추가해주세요.', FALSE, NULL),



(117, 27, 28, '이 문서의 사용자 흐름이 지금보다 더 짧게 보이면 좋습니다.', TRUE, '2026-06-06 09:30:00'),



(118, 28, 29, '주요 포인트만 전달하면 코멘트로 접재도 쉬워집니다.', FALSE, NULL),



(119, 29, 30, '이슈 정리에서 중복가 접입제에서 적어주면 좋고습니다.', FALSE, NULL),



(120, 30, 1, '추가 설명이 필요하면 스크립스타일을 통일해주세요.', TRUE, '2026-06-09 09:30:00'),



(121, 1, 2, '요청하단 설명이에 각인을 더 추가해주세요.', FALSE, NULL),



(122, 2, 3, '이 문서의 사용자 흐름이 지금보다 더 짧게 보이면 좋습니다.', FALSE, NULL),



(123, 3, 4, '주요 포인트만 전달하면 코멘트로 접재도 쉬워집니다.', TRUE, '2026-06-12 09:30:00'),



(124, 4, 5, '이슈 정리에서 중복가 접입제에서 적어주면 좋고습니다.', FALSE, NULL),



(125, 5, 6, '추가 설명이 필요하면 스크립스타일을 통일해주세요.', FALSE, NULL),



(126, 6, 7, '요청하단 설명이에 각인을 더 추가해주세요.', TRUE, '2026-06-15 09:30:00'),



(127, 7, 8, '이 문서의 사용자 흐름이 지금보다 더 짧게 보이면 좋습니다.', FALSE, NULL),



(128, 8, 9, '주요 포인트만 전달하면 코멘트로 접재도 쉬워집니다.', FALSE, NULL),



(129, 9, 10, '이슈 정리에서 중복가 접입제에서 적어주면 좋고습니다.', TRUE, '2026-06-18 09:30:00'),



(130, 10, 11, '추가 설명이 필요하면 스크립스타일을 통일해주세요.', FALSE, NULL),



(131, 11, 12, '요청하단 설명이에 각인을 더 추가해주세요.', FALSE, NULL),



(132, 12, 13, '이 문서의 사용자 흐름이 지금보다 더 짧게 보이면 좋습니다.', TRUE, '2026-06-21 09:30:00'),



(133, 13, 14, '주요 포인트만 전달하면 코멘트로 접재도 쉬워집니다.', FALSE, NULL),



(134, 14, 15, '이슈 정리에서 중복가 접입제에서 적어주면 좋고습니다.', FALSE, NULL),



(135, 15, 16, '추가 설명이 필요하면 스크립스타일을 통일해주세요.', TRUE, '2026-06-24 09:30:00'),



(136, 16, 17, '요청하단 설명이에 각인을 더 추가해주세요.', FALSE, NULL),



(137, 17, 18, '이 문서의 사용자 흐름이 지금보다 더 짧게 보이면 좋습니다.', FALSE, NULL),



(138, 18, 19, '주요 포인트만 전달하면 코멘트로 접재도 쉬워집니다.', TRUE, '2026-06-27 09:30:00'),



(139, 19, 20, '이슈 정리에서 중복가 접입제에서 적어주면 좋고습니다.', FALSE, NULL),



(140, 20, 21, '추가 설명이 필요하면 스크립스타일을 통일해주세요.', FALSE, NULL),



(141, 21, 22, '요청하단 설명이에 각인을 더 추가해주세요.', TRUE, '2026-06-02 09:30:00'),



(142, 22, 23, '이 문서의 사용자 흐름이 지금보다 더 짧게 보이면 좋습니다.', FALSE, NULL),



(143, 23, 24, '주요 포인트만 전달하면 코멘트로 접재도 쉬워집니다.', FALSE, NULL),



(144, 24, 25, '이슈 정리에서 중복가 접입제에서 적어주면 좋고습니다.', TRUE, '2026-06-05 09:30:00'),



(145, 25, 26, '추가 설명이 필요하면 스크립스타일을 통일해주세요.', FALSE, NULL),



(146, 26, 27, '요청하단 설명이에 각인을 더 추가해주세요.', FALSE, NULL),



(147, 27, 28, '이 문서의 사용자 흐름이 지금보다 더 짧게 보이면 좋습니다.', TRUE, '2026-06-08 09:30:00'),



(148, 28, 29, '주요 포인트만 전달하면 코멘트로 접재도 쉬워집니다.', FALSE, NULL),



(149, 29, 30, '이슈 정리에서 중복가 접입제에서 적어주면 좋고습니다.', FALSE, NULL),



(150, 30, 1, '추가 설명이 필요하면 스크립스타일을 통일해주세요.', TRUE, '2026-06-11 09:30:00'),



(151, 1, 2, '요청하단 설명이에 각인을 더 추가해주세요.', FALSE, NULL),



(152, 2, 3, '이 문서의 사용자 흐름이 지금보다 더 짧게 보이면 좋습니다.', FALSE, NULL),



(153, 3, 4, '주요 포인트만 전달하면 코멘트로 접재도 쉬워집니다.', TRUE, '2026-06-14 09:30:00'),



(154, 4, 5, '이슈 정리에서 중복가 접입제에서 적어주면 좋고습니다.', FALSE, NULL),



(155, 5, 6, '추가 설명이 필요하면 스크립스타일을 통일해주세요.', FALSE, NULL),



(156, 6, 7, '요청하단 설명이에 각인을 더 추가해주세요.', TRUE, '2026-06-17 09:30:00'),



(157, 7, 8, '이 문서의 사용자 흐름이 지금보다 더 짧게 보이면 좋습니다.', FALSE, NULL),



(158, 8, 9, '주요 포인트만 전달하면 코멘트로 접재도 쉬워집니다.', FALSE, NULL),



(159, 9, 10, '이슈 정리에서 중복가 접입제에서 적어주면 좋고습니다.', TRUE, '2026-06-20 09:30:00'),



(160, 10, 11, '추가 설명이 필요하면 스크립스타일을 통일해주세요.', FALSE, NULL),



(161, 11, 12, '요청하단 설명이에 각인을 더 추가해주세요.', FALSE, NULL),



(162, 12, 13, '이 문서의 사용자 흐름이 지금보다 더 짧게 보이면 좋습니다.', TRUE, '2026-06-23 09:30:00'),



(163, 13, 14, '주요 포인트만 전달하면 코멘트로 접재도 쉬워집니다.', FALSE, NULL),



(164, 14, 15, '이슈 정리에서 중복가 접입제에서 적어주면 좋고습니다.', FALSE, NULL),



(165, 15, 16, '추가 설명이 필요하면 스크립스타일을 통일해주세요.', TRUE, '2026-06-26 09:30:00'),



(166, 16, 17, '요청하단 설명이에 각인을 더 추가해주세요.', FALSE, NULL),



(167, 17, 18, '이 문서의 사용자 흐름이 지금보다 더 짧게 보이면 좋습니다.', FALSE, NULL),



(168, 18, 19, '주요 포인트만 전달하면 코멘트로 접재도 쉬워집니다.', TRUE, '2026-06-01 09:30:00'),



(169, 19, 20, '이슈 정리에서 중복가 접입제에서 적어주면 좋고습니다.', FALSE, NULL),



(170, 20, 21, '추가 설명이 필요하면 스크립스타일을 통일해주세요.', FALSE, NULL),



(171, 21, 22, '요청하단 설명이에 각인을 더 추가해주세요.', TRUE, '2026-06-04 09:30:00'),



(172, 22, 23, '이 문서의 사용자 흐름이 지금보다 더 짧게 보이면 좋습니다.', FALSE, NULL),



(173, 23, 24, '주요 포인트만 전달하면 코멘트로 접재도 쉬워집니다.', FALSE, NULL),



(174, 24, 25, '이슈 정리에서 중복가 접입제에서 적어주면 좋고습니다.', TRUE, '2026-06-07 09:30:00'),



(175, 25, 26, '추가 설명이 필요하면 스크립스타일을 통일해주세요.', FALSE, NULL),



(176, 26, 27, '요청하단 설명이에 각인을 더 추가해주세요.', FALSE, NULL),



(177, 27, 28, '이 문서의 사용자 흐름이 지금보다 더 짧게 보이면 좋습니다.', TRUE, '2026-06-10 09:30:00'),



(178, 28, 29, '주요 포인트만 전달하면 코멘트로 접재도 쉬워집니다.', FALSE, NULL),



(179, 29, 30, '이슈 정리에서 중복가 접입제에서 적어주면 좋고습니다.', FALSE, NULL),



(180, 30, 1, '추가 설명이 필요하면 스크립스타일을 통일해주세요.', TRUE, '2026-06-13 09:30:00'),



(181, 1, 2, '요청하단 설명이에 각인을 더 추가해주세요.', FALSE, NULL),



(182, 2, 3, '이 문서의 사용자 흐름이 지금보다 더 짧게 보이면 좋습니다.', FALSE, NULL),



(183, 3, 4, '주요 포인트만 전달하면 코멘트로 접재도 쉬워집니다.', TRUE, '2026-06-16 09:30:00'),



(184, 4, 5, '이슈 정리에서 중복가 접입제에서 적어주면 좋고습니다.', FALSE, NULL),



(185, 5, 6, '추가 설명이 필요하면 스크립스타일을 통일해주세요.', FALSE, NULL),



(186, 6, 7, '요청하단 설명이에 각인을 더 추가해주세요.', TRUE, '2026-06-19 09:30:00'),



(187, 7, 8, '이 문서의 사용자 흐름이 지금보다 더 짧게 보이면 좋습니다.', FALSE, NULL),



(188, 8, 9, '주요 포인트만 전달하면 코멘트로 접재도 쉬워집니다.', FALSE, NULL),



(189, 9, 10, '이슈 정리에서 중복가 접입제에서 적어주면 좋고습니다.', TRUE, '2026-06-22 09:30:00'),



(190, 10, 11, '추가 설명이 필요하면 스크립스타일을 통일해주세요.', FALSE, NULL),



(191, 11, 12, '요청하단 설명이에 각인을 더 추가해주세요.', FALSE, NULL),



(192, 12, 13, '이 문서의 사용자 흐름이 지금보다 더 짧게 보이면 좋습니다.', TRUE, '2026-06-25 09:30:00'),



(193, 13, 14, '주요 포인트만 전달하면 코멘트로 접재도 쉬워집니다.', FALSE, NULL),



(194, 14, 15, '이슈 정리에서 중복가 접입제에서 적어주면 좋고습니다.', FALSE, NULL),



(195, 15, 16, '추가 설명이 필요하면 스크립스타일을 통일해주세요.', TRUE, '2026-06-28 09:30:00'),



(196, 16, 17, '요청하단 설명이에 각인을 더 추가해주세요.', FALSE, NULL),



(197, 17, 18, '이 문서의 사용자 흐름이 지금보다 더 짧게 보이면 좋습니다.', FALSE, NULL),



(198, 18, 19, '주요 포인트만 전달하면 코멘트로 접재도 쉬워집니다.', TRUE, '2026-06-03 09:30:00'),



(199, 19, 20, '이슈 정리에서 중복가 접입제에서 적어주면 좋고습니다.', FALSE, NULL),



(200, 20, 21, '추가 설명이 필요하면 스크립스타일을 통일해주세요.', FALSE, NULL);







INSERT INTO notifications (id, user_id, type, title, content, link_url, is_read, read_at) VALUES



(1, 1, 'MESSAGE', '새 메시지 1', '새 메시지가 도착했습니다.', '/app/1/item/1', FALSE, NULL),



(2, 2, 'LIKE', '좋아요 2', '사용자가 포트폴리오를 좋아했습니다.', '/app/2/item/2', FALSE, NULL),



(3, 3, 'BOOKMARK', '보관됨 3', '포트폴리오가 저장되었습니다.', '/app/3/item/3', FALSE, NULL),



(4, 4, 'COMMENT', '회의 4', '새 코멘트가 도착했습니다.', '/app/4/item/4', TRUE, '2026-06-05 11:00:00'),



(5, 5, 'AI', 'AI 5', '아이 검수가 완료되었습니다.', '/app/5/item/5', FALSE, NULL),



(6, 6, 'SYSTEM', '시스템 6', '시스템 상태가 업데이트되었습니다.', '/app/6/item/6', FALSE, NULL),



(7, 7, 'MESSAGE', '새 메시지 7', '새 메시지가 도착했습니다.', '/app/7/item/7', FALSE, NULL),



(8, 8, 'LIKE', '좋아요 8', '사용자가 포트폴리오를 좋아했습니다.', '/app/8/item/8', TRUE, '2026-06-09 11:00:00'),



(9, 9, 'BOOKMARK', '보관됨 9', '포트폴리오가 저장되었습니다.', '/app/9/item/9', FALSE, NULL),



(10, 10, 'COMMENT', '회의 10', '새 코멘트가 도착했습니다.', '/app/10/item/10', FALSE, NULL),



(11, 11, 'AI', 'AI 11', '아이 검수가 완료되었습니다.', '/app/11/item/11', FALSE, NULL),



(12, 12, 'SYSTEM', '시스템 12', '시스템 상태가 업데이트되었습니다.', '/app/12/item/12', TRUE, '2026-06-13 11:00:00'),



(13, 13, 'MESSAGE', '새 메시지 13', '새 메시지가 도착했습니다.', '/app/13/item/13', FALSE, NULL),



(14, 14, 'LIKE', '좋아요 14', '사용자가 포트폴리오를 좋아했습니다.', '/app/14/item/14', FALSE, NULL),



(15, 15, 'BOOKMARK', '보관됨 15', '포트폴리오가 저장되었습니다.', '/app/15/item/15', FALSE, NULL),



(16, 16, 'COMMENT', '회의 16', '새 코멘트가 도착했습니다.', '/app/16/item/16', TRUE, '2026-06-17 11:00:00'),



(17, 17, 'AI', 'AI 17', '아이 검수가 완료되었습니다.', '/app/17/item/17', FALSE, NULL),



(18, 18, 'SYSTEM', '시스템 18', '시스템 상태가 업데이트되었습니다.', '/app/18/item/18', FALSE, NULL),



(19, 19, 'MESSAGE', '새 메시지 19', '새 메시지가 도착했습니다.', '/app/19/item/19', FALSE, NULL),



(20, 20, 'LIKE', '좋아요 20', '사용자가 포트폴리오를 좋아했습니다.', '/app/20/item/20', TRUE, '2026-06-21 11:00:00'),



(21, 21, 'BOOKMARK', '보관됨 21', '포트폴리오가 저장되었습니다.', '/app/21/item/21', FALSE, NULL),



(22, 22, 'COMMENT', '회의 22', '새 코멘트가 도착했습니다.', '/app/22/item/22', FALSE, NULL),



(23, 23, 'AI', 'AI 23', '아이 검수가 완료되었습니다.', '/app/23/item/23', FALSE, NULL),



(24, 24, 'SYSTEM', '시스템 24', '시스템 상태가 업데이트되었습니다.', '/app/24/item/24', TRUE, '2026-06-25 11:00:00'),



(25, 25, 'MESSAGE', '새 메시지 25', '새 메시지가 도착했습니다.', '/app/25/item/25', FALSE, NULL),



(26, 26, 'LIKE', '좋아요 26', '사용자가 포트폴리오를 좋아했습니다.', '/app/26/item/26', FALSE, NULL),



(27, 27, 'BOOKMARK', '보관됨 27', '포트폴리오가 저장되었습니다.', '/app/27/item/27', FALSE, NULL),



(28, 28, 'COMMENT', '회의 28', '새 코멘트가 도착했습니다.', '/app/28/item/28', TRUE, '2026-06-01 11:00:00'),



(29, 29, 'AI', 'AI 29', '아이 검수가 완료되었습니다.', '/app/29/item/29', FALSE, NULL),



(30, 30, 'SYSTEM', '시스템 30', '시스템 상태가 업데이트되었습니다.', '/app/30/item/30', FALSE, NULL),



(31, 1, 'MESSAGE', '새 메시지 31', '새 메시지가 도착했습니다.', '/app/1/item/31', FALSE, NULL),



(32, 2, 'LIKE', '좋아요 32', '사용자가 포트폴리오를 좋아했습니다.', '/app/2/item/32', TRUE, '2026-06-05 11:00:00'),



(33, 3, 'BOOKMARK', '보관됨 33', '포트폴리오가 저장되었습니다.', '/app/3/item/33', FALSE, NULL),



(34, 4, 'COMMENT', '회의 34', '새 코멘트가 도착했습니다.', '/app/4/item/34', FALSE, NULL),



(35, 5, 'AI', 'AI 35', '아이 검수가 완료되었습니다.', '/app/5/item/35', FALSE, NULL),



(36, 6, 'SYSTEM', '시스템 36', '시스템 상태가 업데이트되었습니다.', '/app/6/item/36', TRUE, '2026-06-09 11:00:00'),



(37, 7, 'MESSAGE', '새 메시지 37', '새 메시지가 도착했습니다.', '/app/7/item/37', FALSE, NULL),



(38, 8, 'LIKE', '좋아요 38', '사용자가 포트폴리오를 좋아했습니다.', '/app/8/item/38', FALSE, NULL),



(39, 9, 'BOOKMARK', '보관됨 39', '포트폴리오가 저장되었습니다.', '/app/9/item/39', FALSE, NULL),



(40, 10, 'COMMENT', '회의 40', '새 코멘트가 도착했습니다.', '/app/10/item/40', TRUE, '2026-06-13 11:00:00'),



(41, 11, 'AI', 'AI 41', '아이 검수가 완료되었습니다.', '/app/11/item/41', FALSE, NULL),



(42, 12, 'SYSTEM', '시스템 42', '시스템 상태가 업데이트되었습니다.', '/app/12/item/42', FALSE, NULL),



(43, 13, 'MESSAGE', '새 메시지 43', '새 메시지가 도착했습니다.', '/app/13/item/43', FALSE, NULL),



(44, 14, 'LIKE', '좋아요 44', '사용자가 포트폴리오를 좋아했습니다.', '/app/14/item/44', TRUE, '2026-06-17 11:00:00'),



(45, 15, 'BOOKMARK', '보관됨 45', '포트폴리오가 저장되었습니다.', '/app/15/item/45', FALSE, NULL),



(46, 16, 'COMMENT', '회의 46', '새 코멘트가 도착했습니다.', '/app/16/item/46', FALSE, NULL),



(47, 17, 'AI', 'AI 47', '아이 검수가 완료되었습니다.', '/app/17/item/47', FALSE, NULL),



(48, 18, 'SYSTEM', '시스템 48', '시스템 상태가 업데이트되었습니다.', '/app/18/item/48', TRUE, '2026-06-21 11:00:00'),



(49, 19, 'MESSAGE', '새 메시지 49', '새 메시지가 도착했습니다.', '/app/19/item/49', FALSE, NULL),



(50, 20, 'LIKE', '좋아요 50', '사용자가 포트폴리오를 좋아했습니다.', '/app/20/item/50', FALSE, NULL),



(51, 21, 'BOOKMARK', '보관됨 51', '포트폴리오가 저장되었습니다.', '/app/21/item/51', FALSE, NULL),



(52, 22, 'COMMENT', '회의 52', '새 코멘트가 도착했습니다.', '/app/22/item/52', TRUE, '2026-06-25 11:00:00'),



(53, 23, 'AI', 'AI 53', '아이 검수가 완료되었습니다.', '/app/23/item/53', FALSE, NULL),



(54, 24, 'SYSTEM', '시스템 54', '시스템 상태가 업데이트되었습니다.', '/app/24/item/54', FALSE, NULL),



(55, 25, 'MESSAGE', '새 메시지 55', '새 메시지가 도착했습니다.', '/app/25/item/55', FALSE, NULL),



(56, 26, 'LIKE', '좋아요 56', '사용자가 포트폴리오를 좋아했습니다.', '/app/26/item/56', TRUE, '2026-06-01 11:00:00'),



(57, 27, 'BOOKMARK', '보관됨 57', '포트폴리오가 저장되었습니다.', '/app/27/item/57', FALSE, NULL),



(58, 28, 'COMMENT', '회의 58', '새 코멘트가 도착했습니다.', '/app/28/item/58', FALSE, NULL),



(59, 29, 'AI', 'AI 59', '아이 검수가 완료되었습니다.', '/app/29/item/59', FALSE, NULL),



(60, 30, 'SYSTEM', '시스템 60', '시스템 상태가 업데이트되었습니다.', '/app/30/item/60', TRUE, '2026-06-05 11:00:00'),



(61, 1, 'MESSAGE', '새 메시지 61', '새 메시지가 도착했습니다.', '/app/1/item/61', FALSE, NULL),



(62, 2, 'LIKE', '좋아요 62', '사용자가 포트폴리오를 좋아했습니다.', '/app/2/item/62', FALSE, NULL),



(63, 3, 'BOOKMARK', '보관됨 63', '포트폴리오가 저장되었습니다.', '/app/3/item/63', FALSE, NULL),



(64, 4, 'COMMENT', '회의 64', '새 코멘트가 도착했습니다.', '/app/4/item/64', TRUE, '2026-06-09 11:00:00'),



(65, 5, 'AI', 'AI 65', '아이 검수가 완료되었습니다.', '/app/5/item/65', FALSE, NULL),



(66, 6, 'SYSTEM', '시스템 66', '시스템 상태가 업데이트되었습니다.', '/app/6/item/66', FALSE, NULL),



(67, 7, 'MESSAGE', '새 메시지 67', '새 메시지가 도착했습니다.', '/app/7/item/67', FALSE, NULL),



(68, 8, 'LIKE', '좋아요 68', '사용자가 포트폴리오를 좋아했습니다.', '/app/8/item/68', TRUE, '2026-06-13 11:00:00'),



(69, 9, 'BOOKMARK', '보관됨 69', '포트폴리오가 저장되었습니다.', '/app/9/item/69', FALSE, NULL),



(70, 10, 'COMMENT', '회의 70', '새 코멘트가 도착했습니다.', '/app/10/item/70', FALSE, NULL),



(71, 11, 'AI', 'AI 71', '아이 검수가 완료되었습니다.', '/app/11/item/71', FALSE, NULL),



(72, 12, 'SYSTEM', '시스템 72', '시스템 상태가 업데이트되었습니다.', '/app/12/item/72', TRUE, '2026-06-17 11:00:00'),



(73, 13, 'MESSAGE', '새 메시지 73', '새 메시지가 도착했습니다.', '/app/13/item/73', FALSE, NULL),



(74, 14, 'LIKE', '좋아요 74', '사용자가 포트폴리오를 좋아했습니다.', '/app/14/item/74', FALSE, NULL),



(75, 15, 'BOOKMARK', '보관됨 75', '포트폴리오가 저장되었습니다.', '/app/15/item/75', FALSE, NULL),



(76, 16, 'COMMENT', '회의 76', '새 코멘트가 도착했습니다.', '/app/16/item/76', TRUE, '2026-06-21 11:00:00'),



(77, 17, 'AI', 'AI 77', '아이 검수가 완료되었습니다.', '/app/17/item/77', FALSE, NULL),



(78, 18, 'SYSTEM', '시스템 78', '시스템 상태가 업데이트되었습니다.', '/app/18/item/78', FALSE, NULL),



(79, 19, 'MESSAGE', '새 메시지 79', '새 메시지가 도착했습니다.', '/app/19/item/79', FALSE, NULL),



(80, 20, 'LIKE', '좋아요 80', '사용자가 포트폴리오를 좋아했습니다.', '/app/20/item/80', TRUE, '2026-06-25 11:00:00'),



(81, 21, 'BOOKMARK', '보관됨 81', '포트폴리오가 저장되었습니다.', '/app/21/item/81', FALSE, NULL),



(82, 22, 'COMMENT', '회의 82', '새 코멘트가 도착했습니다.', '/app/22/item/82', FALSE, NULL),



(83, 23, 'AI', 'AI 83', '아이 검수가 완료되었습니다.', '/app/23/item/83', FALSE, NULL),



(84, 24, 'SYSTEM', '시스템 84', '시스템 상태가 업데이트되었습니다.', '/app/24/item/84', TRUE, '2026-06-01 11:00:00'),



(85, 25, 'MESSAGE', '새 메시지 85', '새 메시지가 도착했습니다.', '/app/25/item/85', FALSE, NULL),



(86, 26, 'LIKE', '좋아요 86', '사용자가 포트폴리오를 좋아했습니다.', '/app/26/item/86', FALSE, NULL),



(87, 27, 'BOOKMARK', '보관됨 87', '포트폴리오가 저장되었습니다.', '/app/27/item/87', FALSE, NULL),



(88, 28, 'COMMENT', '회의 88', '새 코멘트가 도착했습니다.', '/app/28/item/88', TRUE, '2026-06-05 11:00:00'),



(89, 29, 'AI', 'AI 89', '아이 검수가 완료되었습니다.', '/app/29/item/89', FALSE, NULL),



(90, 30, 'SYSTEM', '시스템 90', '시스템 상태가 업데이트되었습니다.', '/app/30/item/90', FALSE, NULL),



(91, 1, 'MESSAGE', '새 메시지 91', '새 메시지가 도착했습니다.', '/app/1/item/91', FALSE, NULL),



(92, 2, 'LIKE', '좋아요 92', '사용자가 포트폴리오를 좋아했습니다.', '/app/2/item/92', TRUE, '2026-06-09 11:00:00'),



(93, 3, 'BOOKMARK', '보관됨 93', '포트폴리오가 저장되었습니다.', '/app/3/item/93', FALSE, NULL),



(94, 4, 'COMMENT', '회의 94', '새 코멘트가 도착했습니다.', '/app/4/item/94', FALSE, NULL),



(95, 5, 'AI', 'AI 95', '아이 검수가 완료되었습니다.', '/app/5/item/95', FALSE, NULL),



(96, 6, 'SYSTEM', '시스템 96', '시스템 상태가 업데이트되었습니다.', '/app/6/item/96', TRUE, '2026-06-13 11:00:00'),



(97, 7, 'MESSAGE', '새 메시지 97', '새 메시지가 도착했습니다.', '/app/7/item/97', FALSE, NULL),



(98, 8, 'LIKE', '좋아요 98', '사용자가 포트폴리오를 좋아했습니다.', '/app/8/item/98', FALSE, NULL),



(99, 9, 'BOOKMARK', '보관됨 99', '포트폴리오가 저장되었습니다.', '/app/9/item/99', FALSE, NULL),



(100, 10, 'COMMENT', '회의 100', '새 코멘트가 도착했습니다.', '/app/10/item/100', TRUE, '2026-06-17 11:00:00'),



(101, 11, 'AI', 'AI 101', '아이 검수가 완료되었습니다.', '/app/11/item/101', FALSE, NULL),



(102, 12, 'SYSTEM', '시스템 102', '시스템 상태가 업데이트되었습니다.', '/app/12/item/102', FALSE, NULL),



(103, 13, 'MESSAGE', '새 메시지 103', '새 메시지가 도착했습니다.', '/app/13/item/103', FALSE, NULL),



(104, 14, 'LIKE', '좋아요 104', '사용자가 포트폴리오를 좋아했습니다.', '/app/14/item/104', TRUE, '2026-06-21 11:00:00'),



(105, 15, 'BOOKMARK', '보관됨 105', '포트폴리오가 저장되었습니다.', '/app/15/item/105', FALSE, NULL),



(106, 16, 'COMMENT', '회의 106', '새 코멘트가 도착했습니다.', '/app/16/item/106', FALSE, NULL),



(107, 17, 'AI', 'AI 107', '아이 검수가 완료되었습니다.', '/app/17/item/107', FALSE, NULL),



(108, 18, 'SYSTEM', '시스템 108', '시스템 상태가 업데이트되었습니다.', '/app/18/item/108', TRUE, '2026-06-25 11:00:00'),



(109, 19, 'MESSAGE', '새 메시지 109', '새 메시지가 도착했습니다.', '/app/19/item/109', FALSE, NULL),



(110, 20, 'LIKE', '좋아요 110', '사용자가 포트폴리오를 좋아했습니다.', '/app/20/item/110', FALSE, NULL),



(111, 21, 'BOOKMARK', '보관됨 111', '포트폴리오가 저장되었습니다.', '/app/21/item/111', FALSE, NULL),



(112, 22, 'COMMENT', '회의 112', '새 코멘트가 도착했습니다.', '/app/22/item/112', TRUE, '2026-06-01 11:00:00'),



(113, 23, 'AI', 'AI 113', '아이 검수가 완료되었습니다.', '/app/23/item/113', FALSE, NULL),



(114, 24, 'SYSTEM', '시스템 114', '시스템 상태가 업데이트되었습니다.', '/app/24/item/114', FALSE, NULL),



(115, 25, 'MESSAGE', '새 메시지 115', '새 메시지가 도착했습니다.', '/app/25/item/115', FALSE, NULL),



(116, 26, 'LIKE', '좋아요 116', '사용자가 포트폴리오를 좋아했습니다.', '/app/26/item/116', TRUE, '2026-06-05 11:00:00'),



(117, 27, 'BOOKMARK', '보관됨 117', '포트폴리오가 저장되었습니다.', '/app/27/item/117', FALSE, NULL),



(118, 28, 'COMMENT', '회의 118', '새 코멘트가 도착했습니다.', '/app/28/item/118', FALSE, NULL),



(119, 29, 'AI', 'AI 119', '아이 검수가 완료되었습니다.', '/app/29/item/119', FALSE, NULL),



(120, 30, 'SYSTEM', '시스템 120', '시스템 상태가 업데이트되었습니다.', '/app/30/item/120', TRUE, '2026-06-09 11:00:00'),



(121, 1, 'MESSAGE', '새 메시지 121', '새 메시지가 도착했습니다.', '/app/1/item/121', FALSE, NULL),



(122, 2, 'LIKE', '좋아요 122', '사용자가 포트폴리오를 좋아했습니다.', '/app/2/item/122', FALSE, NULL),



(123, 3, 'BOOKMARK', '보관됨 123', '포트폴리오가 저장되었습니다.', '/app/3/item/123', FALSE, NULL),



(124, 4, 'COMMENT', '회의 124', '새 코멘트가 도착했습니다.', '/app/4/item/124', TRUE, '2026-06-13 11:00:00'),



(125, 5, 'AI', 'AI 125', '아이 검수가 완료되었습니다.', '/app/5/item/125', FALSE, NULL),



(126, 6, 'SYSTEM', '시스템 126', '시스템 상태가 업데이트되었습니다.', '/app/6/item/126', FALSE, NULL),



(127, 7, 'MESSAGE', '새 메시지 127', '새 메시지가 도착했습니다.', '/app/7/item/127', FALSE, NULL),



(128, 8, 'LIKE', '좋아요 128', '사용자가 포트폴리오를 좋아했습니다.', '/app/8/item/128', TRUE, '2026-06-17 11:00:00'),



(129, 9, 'BOOKMARK', '보관됨 129', '포트폴리오가 저장되었습니다.', '/app/9/item/129', FALSE, NULL),



(130, 10, 'COMMENT', '회의 130', '새 코멘트가 도착했습니다.', '/app/10/item/130', FALSE, NULL),



(131, 11, 'AI', 'AI 131', '아이 검수가 완료되었습니다.', '/app/11/item/131', FALSE, NULL),



(132, 12, 'SYSTEM', '시스템 132', '시스템 상태가 업데이트되었습니다.', '/app/12/item/132', TRUE, '2026-06-21 11:00:00'),



(133, 13, 'MESSAGE', '새 메시지 133', '새 메시지가 도착했습니다.', '/app/13/item/133', FALSE, NULL),



(134, 14, 'LIKE', '좋아요 134', '사용자가 포트폴리오를 좋아했습니다.', '/app/14/item/134', FALSE, NULL),



(135, 15, 'BOOKMARK', '보관됨 135', '포트폴리오가 저장되었습니다.', '/app/15/item/135', FALSE, NULL),



(136, 16, 'COMMENT', '회의 136', '새 코멘트가 도착했습니다.', '/app/16/item/136', TRUE, '2026-06-25 11:00:00'),



(137, 17, 'AI', 'AI 137', '아이 검수가 완료되었습니다.', '/app/17/item/137', FALSE, NULL),



(138, 18, 'SYSTEM', '시스템 138', '시스템 상태가 업데이트되었습니다.', '/app/18/item/138', FALSE, NULL),



(139, 19, 'MESSAGE', '새 메시지 139', '새 메시지가 도착했습니다.', '/app/19/item/139', FALSE, NULL),



(140, 20, 'LIKE', '좋아요 140', '사용자가 포트폴리오를 좋아했습니다.', '/app/20/item/140', TRUE, '2026-06-01 11:00:00'),



(141, 21, 'BOOKMARK', '보관됨 141', '포트폴리오가 저장되었습니다.', '/app/21/item/141', FALSE, NULL),



(142, 22, 'COMMENT', '회의 142', '새 코멘트가 도착했습니다.', '/app/22/item/142', FALSE, NULL),



(143, 23, 'AI', 'AI 143', '아이 검수가 완료되었습니다.', '/app/23/item/143', FALSE, NULL),



(144, 24, 'SYSTEM', '시스템 144', '시스템 상태가 업데이트되었습니다.', '/app/24/item/144', TRUE, '2026-06-05 11:00:00'),



(145, 25, 'MESSAGE', '새 메시지 145', '새 메시지가 도착했습니다.', '/app/25/item/145', FALSE, NULL),



(146, 26, 'LIKE', '좋아요 146', '사용자가 포트폴리오를 좋아했습니다.', '/app/26/item/146', FALSE, NULL),



(147, 27, 'BOOKMARK', '보관됨 147', '포트폴리오가 저장되었습니다.', '/app/27/item/147', FALSE, NULL),



(148, 28, 'COMMENT', '회의 148', '새 코멘트가 도착했습니다.', '/app/28/item/148', TRUE, '2026-06-09 11:00:00'),



(149, 29, 'AI', 'AI 149', '아이 검수가 완료되었습니다.', '/app/29/item/149', FALSE, NULL),



(150, 30, 'SYSTEM', '시스템 150', '시스템 상태가 업데이트되었습니다.', '/app/30/item/150', FALSE, NULL),



(151, 1, 'MESSAGE', '새 메시지 151', '새 메시지가 도착했습니다.', '/app/1/item/151', FALSE, NULL),



(152, 2, 'LIKE', '좋아요 152', '사용자가 포트폴리오를 좋아했습니다.', '/app/2/item/152', TRUE, '2026-06-13 11:00:00'),



(153, 3, 'BOOKMARK', '보관됨 153', '포트폴리오가 저장되었습니다.', '/app/3/item/153', FALSE, NULL),



(154, 4, 'COMMENT', '회의 154', '새 코멘트가 도착했습니다.', '/app/4/item/154', FALSE, NULL),



(155, 5, 'AI', 'AI 155', '아이 검수가 완료되었습니다.', '/app/5/item/155', FALSE, NULL),



(156, 6, 'SYSTEM', '시스템 156', '시스템 상태가 업데이트되었습니다.', '/app/6/item/156', TRUE, '2026-06-17 11:00:00'),



(157, 7, 'MESSAGE', '새 메시지 157', '새 메시지가 도착했습니다.', '/app/7/item/157', FALSE, NULL),



(158, 8, 'LIKE', '좋아요 158', '사용자가 포트폴리오를 좋아했습니다.', '/app/8/item/158', FALSE, NULL),



(159, 9, 'BOOKMARK', '보관됨 159', '포트폴리오가 저장되었습니다.', '/app/9/item/159', FALSE, NULL),



(160, 10, 'COMMENT', '회의 160', '새 코멘트가 도착했습니다.', '/app/10/item/160', TRUE, '2026-06-21 11:00:00'),



(161, 11, 'AI', 'AI 161', '아이 검수가 완료되었습니다.', '/app/11/item/161', FALSE, NULL),



(162, 12, 'SYSTEM', '시스템 162', '시스템 상태가 업데이트되었습니다.', '/app/12/item/162', FALSE, NULL),



(163, 13, 'MESSAGE', '새 메시지 163', '새 메시지가 도착했습니다.', '/app/13/item/163', FALSE, NULL),



(164, 14, 'LIKE', '좋아요 164', '사용자가 포트폴리오를 좋아했습니다.', '/app/14/item/164', TRUE, '2026-06-25 11:00:00'),



(165, 15, 'BOOKMARK', '보관됨 165', '포트폴리오가 저장되었습니다.', '/app/15/item/165', FALSE, NULL),



(166, 16, 'COMMENT', '회의 166', '새 코멘트가 도착했습니다.', '/app/16/item/166', FALSE, NULL),



(167, 17, 'AI', 'AI 167', '아이 검수가 완료되었습니다.', '/app/17/item/167', FALSE, NULL),



(168, 18, 'SYSTEM', '시스템 168', '시스템 상태가 업데이트되었습니다.', '/app/18/item/168', TRUE, '2026-06-01 11:00:00'),



(169, 19, 'MESSAGE', '새 메시지 169', '새 메시지가 도착했습니다.', '/app/19/item/169', FALSE, NULL),



(170, 20, 'LIKE', '좋아요 170', '사용자가 포트폴리오를 좋아했습니다.', '/app/20/item/170', FALSE, NULL),



(171, 21, 'BOOKMARK', '보관됨 171', '포트폴리오가 저장되었습니다.', '/app/21/item/171', FALSE, NULL),



(172, 22, 'COMMENT', '회의 172', '새 코멘트가 도착했습니다.', '/app/22/item/172', TRUE, '2026-06-05 11:00:00'),



(173, 23, 'AI', 'AI 173', '아이 검수가 완료되었습니다.', '/app/23/item/173', FALSE, NULL),



(174, 24, 'SYSTEM', '시스템 174', '시스템 상태가 업데이트되었습니다.', '/app/24/item/174', FALSE, NULL),



(175, 25, 'MESSAGE', '새 메시지 175', '새 메시지가 도착했습니다.', '/app/25/item/175', FALSE, NULL),



(176, 26, 'LIKE', '좋아요 176', '사용자가 포트폴리오를 좋아했습니다.', '/app/26/item/176', TRUE, '2026-06-09 11:00:00'),



(177, 27, 'BOOKMARK', '보관됨 177', '포트폴리오가 저장되었습니다.', '/app/27/item/177', FALSE, NULL),



(178, 28, 'COMMENT', '회의 178', '새 코멘트가 도착했습니다.', '/app/28/item/178', FALSE, NULL),



(179, 29, 'AI', 'AI 179', '아이 검수가 완료되었습니다.', '/app/29/item/179', FALSE, NULL),



(180, 30, 'SYSTEM', '시스템 180', '시스템 상태가 업데이트되었습니다.', '/app/30/item/180', TRUE, '2026-06-13 11:00:00'),



(181, 1, 'MESSAGE', '새 메시지 181', '새 메시지가 도착했습니다.', '/app/1/item/181', FALSE, NULL),



(182, 2, 'LIKE', '좋아요 182', '사용자가 포트폴리오를 좋아했습니다.', '/app/2/item/182', FALSE, NULL),



(183, 3, 'BOOKMARK', '보관됨 183', '포트폴리오가 저장되었습니다.', '/app/3/item/183', FALSE, NULL),



(184, 4, 'COMMENT', '회의 184', '새 코멘트가 도착했습니다.', '/app/4/item/184', TRUE, '2026-06-17 11:00:00'),



(185, 5, 'AI', 'AI 185', '아이 검수가 완료되었습니다.', '/app/5/item/185', FALSE, NULL),



(186, 6, 'SYSTEM', '시스템 186', '시스템 상태가 업데이트되었습니다.', '/app/6/item/186', FALSE, NULL),



(187, 7, 'MESSAGE', '새 메시지 187', '새 메시지가 도착했습니다.', '/app/7/item/187', FALSE, NULL),



(188, 8, 'LIKE', '좋아요 188', '사용자가 포트폴리오를 좋아했습니다.', '/app/8/item/188', TRUE, '2026-06-21 11:00:00'),



(189, 9, 'BOOKMARK', '보관됨 189', '포트폴리오가 저장되었습니다.', '/app/9/item/189', FALSE, NULL),



(190, 10, 'COMMENT', '회의 190', '새 코멘트가 도착했습니다.', '/app/10/item/190', FALSE, NULL),



(191, 11, 'AI', 'AI 191', '아이 검수가 완료되었습니다.', '/app/11/item/191', FALSE, NULL),



(192, 12, 'SYSTEM', '시스템 192', '시스템 상태가 업데이트되었습니다.', '/app/12/item/192', TRUE, '2026-06-25 11:00:00'),



(193, 13, 'MESSAGE', '새 메시지 193', '새 메시지가 도착했습니다.', '/app/13/item/193', FALSE, NULL),



(194, 14, 'LIKE', '좋아요 194', '사용자가 포트폴리오를 좋아했습니다.', '/app/14/item/194', FALSE, NULL),



(195, 15, 'BOOKMARK', '보관됨 195', '포트폴리오가 저장되었습니다.', '/app/15/item/195', FALSE, NULL),



(196, 16, 'COMMENT', '회의 196', '새 코멘트가 도착했습니다.', '/app/16/item/196', TRUE, '2026-06-01 11:00:00'),



(197, 17, 'AI', 'AI 197', '아이 검수가 완료되었습니다.', '/app/17/item/197', FALSE, NULL),



(198, 18, 'SYSTEM', '시스템 198', '시스템 상태가 업데이트되었습니다.', '/app/18/item/198', FALSE, NULL),



(199, 19, 'MESSAGE', '새 메시지 199', '새 메시지가 도착했습니다.', '/app/19/item/199', FALSE, NULL),



(200, 20, 'LIKE', '좋아요 200', '사용자가 포트폴리오를 좋아했습니다.', '/app/20/item/200', TRUE, '2026-06-05 11:00:00');



INSERT INTO notifications (id, user_id, type, title, content, link_url, is_read, read_at) VALUES



(201, 21, 'BOOKMARK', '보관됨 201', '포트폴리오가 저장되었습니다.', '/app/21/item/201', FALSE, NULL),



(202, 22, 'COMMENT', '회의 202', '새 코멘트가 도착했습니다.', '/app/22/item/202', FALSE, NULL),



(203, 23, 'AI', 'AI 203', '아이 검수가 완료되었습니다.', '/app/23/item/203', FALSE, NULL),



(204, 24, 'SYSTEM', '시스템 204', '시스템 상태가 업데이트되었습니다.', '/app/24/item/204', TRUE, '2026-06-09 11:00:00'),



(205, 25, 'MESSAGE', '새 메시지 205', '새 메시지가 도착했습니다.', '/app/25/item/205', FALSE, NULL),



(206, 26, 'LIKE', '좋아요 206', '사용자가 포트폴리오를 좋아했습니다.', '/app/26/item/206', FALSE, NULL),



(207, 27, 'BOOKMARK', '보관됨 207', '포트폴리오가 저장되었습니다.', '/app/27/item/207', FALSE, NULL),



(208, 28, 'COMMENT', '회의 208', '새 코멘트가 도착했습니다.', '/app/28/item/208', TRUE, '2026-06-13 11:00:00'),



(209, 29, 'AI', 'AI 209', '아이 검수가 완료되었습니다.', '/app/29/item/209', FALSE, NULL),



(210, 30, 'SYSTEM', '시스템 210', '시스템 상태가 업데이트되었습니다.', '/app/30/item/210', FALSE, NULL),



(211, 1, 'MESSAGE', '새 메시지 211', '새 메시지가 도착했습니다.', '/app/1/item/211', FALSE, NULL),



(212, 2, 'LIKE', '좋아요 212', '사용자가 포트폴리오를 좋아했습니다.', '/app/2/item/212', TRUE, '2026-06-17 11:00:00'),



(213, 3, 'BOOKMARK', '보관됨 213', '포트폴리오가 저장되었습니다.', '/app/3/item/213', FALSE, NULL),



(214, 4, 'COMMENT', '회의 214', '새 코멘트가 도착했습니다.', '/app/4/item/214', FALSE, NULL),



(215, 5, 'AI', 'AI 215', '아이 검수가 완료되었습니다.', '/app/5/item/215', FALSE, NULL),



(216, 6, 'SYSTEM', '시스템 216', '시스템 상태가 업데이트되었습니다.', '/app/6/item/216', TRUE, '2026-06-21 11:00:00'),



(217, 7, 'MESSAGE', '새 메시지 217', '새 메시지가 도착했습니다.', '/app/7/item/217', FALSE, NULL),



(218, 8, 'LIKE', '좋아요 218', '사용자가 포트폴리오를 좋아했습니다.', '/app/8/item/218', FALSE, NULL),



(219, 9, 'BOOKMARK', '보관됨 219', '포트폴리오가 저장되었습니다.', '/app/9/item/219', FALSE, NULL),



(220, 10, 'COMMENT', '회의 220', '새 코멘트가 도착했습니다.', '/app/10/item/220', TRUE, '2026-06-25 11:00:00'),



(221, 11, 'AI', 'AI 221', '아이 검수가 완료되었습니다.', '/app/11/item/221', FALSE, NULL),



(222, 12, 'SYSTEM', '시스템 222', '시스템 상태가 업데이트되었습니다.', '/app/12/item/222', FALSE, NULL),



(223, 13, 'MESSAGE', '새 메시지 223', '새 메시지가 도착했습니다.', '/app/13/item/223', FALSE, NULL),



(224, 14, 'LIKE', '좋아요 224', '사용자가 포트폴리오를 좋아했습니다.', '/app/14/item/224', TRUE, '2026-06-01 11:00:00'),



(225, 15, 'BOOKMARK', '보관됨 225', '포트폴리오가 저장되었습니다.', '/app/15/item/225', FALSE, NULL),



(226, 16, 'COMMENT', '회의 226', '새 코멘트가 도착했습니다.', '/app/16/item/226', FALSE, NULL),



(227, 17, 'AI', 'AI 227', '아이 검수가 완료되었습니다.', '/app/17/item/227', FALSE, NULL),



(228, 18, 'SYSTEM', '시스템 228', '시스템 상태가 업데이트되었습니다.', '/app/18/item/228', TRUE, '2026-06-05 11:00:00'),



(229, 19, 'MESSAGE', '새 메시지 229', '새 메시지가 도착했습니다.', '/app/19/item/229', FALSE, NULL),



(230, 20, 'LIKE', '좋아요 230', '사용자가 포트폴리오를 좋아했습니다.', '/app/20/item/230', FALSE, NULL),



(231, 21, 'BOOKMARK', '보관됨 231', '포트폴리오가 저장되었습니다.', '/app/21/item/231', FALSE, NULL),



(232, 22, 'COMMENT', '회의 232', '새 코멘트가 도착했습니다.', '/app/22/item/232', TRUE, '2026-06-09 11:00:00'),



(233, 23, 'AI', 'AI 233', '아이 검수가 완료되었습니다.', '/app/23/item/233', FALSE, NULL),



(234, 24, 'SYSTEM', '시스템 234', '시스템 상태가 업데이트되었습니다.', '/app/24/item/234', FALSE, NULL),



(235, 25, 'MESSAGE', '새 메시지 235', '새 메시지가 도착했습니다.', '/app/25/item/235', FALSE, NULL),



(236, 26, 'LIKE', '좋아요 236', '사용자가 포트폴리오를 좋아했습니다.', '/app/26/item/236', TRUE, '2026-06-13 11:00:00'),



(237, 27, 'BOOKMARK', '보관됨 237', '포트폴리오가 저장되었습니다.', '/app/27/item/237', FALSE, NULL),



(238, 28, 'COMMENT', '회의 238', '새 코멘트가 도착했습니다.', '/app/28/item/238', FALSE, NULL),



(239, 29, 'AI', 'AI 239', '아이 검수가 완료되었습니다.', '/app/29/item/239', FALSE, NULL),



(240, 30, 'SYSTEM', '시스템 240', '시스템 상태가 업데이트되었습니다.', '/app/30/item/240', TRUE, '2026-06-17 11:00:00'),



(241, 1, 'MESSAGE', '새 메시지 241', '새 메시지가 도착했습니다.', '/app/1/item/241', FALSE, NULL),



(242, 2, 'LIKE', '좋아요 242', '사용자가 포트폴리오를 좋아했습니다.', '/app/2/item/242', FALSE, NULL),



(243, 3, 'BOOKMARK', '보관됨 243', '포트폴리오가 저장되었습니다.', '/app/3/item/243', FALSE, NULL),



(244, 4, 'COMMENT', '회의 244', '새 코멘트가 도착했습니다.', '/app/4/item/244', TRUE, '2026-06-21 11:00:00'),



(245, 5, 'AI', 'AI 245', '아이 검수가 완료되었습니다.', '/app/5/item/245', FALSE, NULL),



(246, 6, 'SYSTEM', '시스템 246', '시스템 상태가 업데이트되었습니다.', '/app/6/item/246', FALSE, NULL),



(247, 7, 'MESSAGE', '새 메시지 247', '새 메시지가 도착했습니다.', '/app/7/item/247', FALSE, NULL),



(248, 8, 'LIKE', '좋아요 248', '사용자가 포트폴리오를 좋아했습니다.', '/app/8/item/248', TRUE, '2026-06-25 11:00:00'),



(249, 9, 'BOOKMARK', '보관됨 249', '포트폴리오가 저장되었습니다.', '/app/9/item/249', FALSE, NULL),



(250, 10, 'COMMENT', '회의 250', '새 코멘트가 도착했습니다.', '/app/10/item/250', FALSE, NULL),



(251, 11, 'AI', 'AI 251', '아이 검수가 완료되었습니다.', '/app/11/item/251', FALSE, NULL),



(252, 12, 'SYSTEM', '시스템 252', '시스템 상태가 업데이트되었습니다.', '/app/12/item/252', TRUE, '2026-06-01 11:00:00'),



(253, 13, 'MESSAGE', '새 메시지 253', '새 메시지가 도착했습니다.', '/app/13/item/253', FALSE, NULL),



(254, 14, 'LIKE', '좋아요 254', '사용자가 포트폴리오를 좋아했습니다.', '/app/14/item/254', FALSE, NULL),



(255, 15, 'BOOKMARK', '보관됨 255', '포트폴리오가 저장되었습니다.', '/app/15/item/255', FALSE, NULL),



(256, 16, 'COMMENT', '회의 256', '새 코멘트가 도착했습니다.', '/app/16/item/256', TRUE, '2026-06-05 11:00:00'),



(257, 17, 'AI', 'AI 257', '아이 검수가 완료되었습니다.', '/app/17/item/257', FALSE, NULL),



(258, 18, 'SYSTEM', '시스템 258', '시스템 상태가 업데이트되었습니다.', '/app/18/item/258', FALSE, NULL),



(259, 19, 'MESSAGE', '새 메시지 259', '새 메시지가 도착했습니다.', '/app/19/item/259', FALSE, NULL),



(260, 20, 'LIKE', '좋아요 260', '사용자가 포트폴리오를 좋아했습니다.', '/app/20/item/260', TRUE, '2026-06-09 11:00:00'),



(261, 21, 'BOOKMARK', '보관됨 261', '포트폴리오가 저장되었습니다.', '/app/21/item/261', FALSE, NULL),



(262, 22, 'COMMENT', '회의 262', '새 코멘트가 도착했습니다.', '/app/22/item/262', FALSE, NULL),



(263, 23, 'AI', 'AI 263', '아이 검수가 완료되었습니다.', '/app/23/item/263', FALSE, NULL),



(264, 24, 'SYSTEM', '시스템 264', '시스템 상태가 업데이트되었습니다.', '/app/24/item/264', TRUE, '2026-06-13 11:00:00'),



(265, 25, 'MESSAGE', '새 메시지 265', '새 메시지가 도착했습니다.', '/app/25/item/265', FALSE, NULL),



(266, 26, 'LIKE', '좋아요 266', '사용자가 포트폴리오를 좋아했습니다.', '/app/26/item/266', FALSE, NULL),



(267, 27, 'BOOKMARK', '보관됨 267', '포트폴리오가 저장되었습니다.', '/app/27/item/267', FALSE, NULL),



(268, 28, 'COMMENT', '회의 268', '새 코멘트가 도착했습니다.', '/app/28/item/268', TRUE, '2026-06-17 11:00:00'),



(269, 29, 'AI', 'AI 269', '아이 검수가 완료되었습니다.', '/app/29/item/269', FALSE, NULL),



(270, 30, 'SYSTEM', '시스템 270', '시스템 상태가 업데이트되었습니다.', '/app/30/item/270', FALSE, NULL),



(271, 1, 'MESSAGE', '새 메시지 271', '새 메시지가 도착했습니다.', '/app/1/item/271', FALSE, NULL),



(272, 2, 'LIKE', '좋아요 272', '사용자가 포트폴리오를 좋아했습니다.', '/app/2/item/272', TRUE, '2026-06-21 11:00:00'),



(273, 3, 'BOOKMARK', '보관됨 273', '포트폴리오가 저장되었습니다.', '/app/3/item/273', FALSE, NULL),



(274, 4, 'COMMENT', '회의 274', '새 코멘트가 도착했습니다.', '/app/4/item/274', FALSE, NULL),



(275, 5, 'AI', 'AI 275', '아이 검수가 완료되었습니다.', '/app/5/item/275', FALSE, NULL),



(276, 6, 'SYSTEM', '시스템 276', '시스템 상태가 업데이트되었습니다.', '/app/6/item/276', TRUE, '2026-06-25 11:00:00'),



(277, 7, 'MESSAGE', '새 메시지 277', '새 메시지가 도착했습니다.', '/app/7/item/277', FALSE, NULL),



(278, 8, 'LIKE', '좋아요 278', '사용자가 포트폴리오를 좋아했습니다.', '/app/8/item/278', FALSE, NULL),



(279, 9, 'BOOKMARK', '보관됨 279', '포트폴리오가 저장되었습니다.', '/app/9/item/279', FALSE, NULL),



(280, 10, 'COMMENT', '회의 280', '새 코멘트가 도착했습니다.', '/app/10/item/280', TRUE, '2026-06-01 11:00:00'),



(281, 11, 'AI', 'AI 281', '아이 검수가 완료되었습니다.', '/app/11/item/281', FALSE, NULL),



(282, 12, 'SYSTEM', '시스템 282', '시스템 상태가 업데이트되었습니다.', '/app/12/item/282', FALSE, NULL),



(283, 13, 'MESSAGE', '새 메시지 283', '새 메시지가 도착했습니다.', '/app/13/item/283', FALSE, NULL),



(284, 14, 'LIKE', '좋아요 284', '사용자가 포트폴리오를 좋아했습니다.', '/app/14/item/284', TRUE, '2026-06-05 11:00:00'),



(285, 15, 'BOOKMARK', '보관됨 285', '포트폴리오가 저장되었습니다.', '/app/15/item/285', FALSE, NULL),



(286, 16, 'COMMENT', '회의 286', '새 코멘트가 도착했습니다.', '/app/16/item/286', FALSE, NULL),



(287, 17, 'AI', 'AI 287', '아이 검수가 완료되었습니다.', '/app/17/item/287', FALSE, NULL),



(288, 18, 'SYSTEM', '시스템 288', '시스템 상태가 업데이트되었습니다.', '/app/18/item/288', TRUE, '2026-06-09 11:00:00'),



(289, 19, 'MESSAGE', '새 메시지 289', '새 메시지가 도착했습니다.', '/app/19/item/289', FALSE, NULL),



(290, 20, 'LIKE', '좋아요 290', '사용자가 포트폴리오를 좋아했습니다.', '/app/20/item/290', FALSE, NULL),



(291, 21, 'BOOKMARK', '보관됨 291', '포트폴리오가 저장되었습니다.', '/app/21/item/291', FALSE, NULL),



(292, 22, 'COMMENT', '회의 292', '새 코멘트가 도착했습니다.', '/app/22/item/292', TRUE, '2026-06-13 11:00:00'),



(293, 23, 'AI', 'AI 293', '아이 검수가 완료되었습니다.', '/app/23/item/293', FALSE, NULL),



(294, 24, 'SYSTEM', '시스템 294', '시스템 상태가 업데이트되었습니다.', '/app/24/item/294', FALSE, NULL),



(295, 25, 'MESSAGE', '새 메시지 295', '새 메시지가 도착했습니다.', '/app/25/item/295', FALSE, NULL),



(296, 26, 'LIKE', '좋아요 296', '사용자가 포트폴리오를 좋아했습니다.', '/app/26/item/296', TRUE, '2026-06-17 11:00:00'),



(297, 27, 'BOOKMARK', '보관됨 297', '포트폴리오가 저장되었습니다.', '/app/27/item/297', FALSE, NULL),



(298, 28, 'COMMENT', '회의 298', '새 코멘트가 도착했습니다.', '/app/28/item/298', FALSE, NULL),



(299, 29, 'AI', 'AI 299', '아이 검수가 완료되었습니다.', '/app/29/item/299', FALSE, NULL),



(300, 30, 'SYSTEM', '시스템 300', '시스템 상태가 업데이트되었습니다.', '/app/30/item/300', TRUE, '2026-06-21 11:00:00'),



(301, 1, 'MESSAGE', '새 메시지 301', '새 메시지가 도착했습니다.', '/app/1/item/301', FALSE, NULL),



(302, 2, 'LIKE', '좋아요 302', '사용자가 포트폴리오를 좋아했습니다.', '/app/2/item/302', FALSE, NULL),



(303, 3, 'BOOKMARK', '보관됨 303', '포트폴리오가 저장되었습니다.', '/app/3/item/303', FALSE, NULL),



(304, 4, 'COMMENT', '회의 304', '새 코멘트가 도착했습니다.', '/app/4/item/304', TRUE, '2026-06-25 11:00:00'),



(305, 5, 'AI', 'AI 305', '아이 검수가 완료되었습니다.', '/app/5/item/305', FALSE, NULL),



(306, 6, 'SYSTEM', '시스템 306', '시스템 상태가 업데이트되었습니다.', '/app/6/item/306', FALSE, NULL),



(307, 7, 'MESSAGE', '새 메시지 307', '새 메시지가 도착했습니다.', '/app/7/item/307', FALSE, NULL),



(308, 8, 'LIKE', '좋아요 308', '사용자가 포트폴리오를 좋아했습니다.', '/app/8/item/308', TRUE, '2026-06-01 11:00:00'),



(309, 9, 'BOOKMARK', '보관됨 309', '포트폴리오가 저장되었습니다.', '/app/9/item/309', FALSE, NULL),



(310, 10, 'COMMENT', '회의 310', '새 코멘트가 도착했습니다.', '/app/10/item/310', FALSE, NULL),



(311, 11, 'AI', 'AI 311', '아이 검수가 완료되었습니다.', '/app/11/item/311', FALSE, NULL),



(312, 12, 'SYSTEM', '시스템 312', '시스템 상태가 업데이트되었습니다.', '/app/12/item/312', TRUE, '2026-06-05 11:00:00'),



(313, 13, 'MESSAGE', '새 메시지 313', '새 메시지가 도착했습니다.', '/app/13/item/313', FALSE, NULL),



(314, 14, 'LIKE', '좋아요 314', '사용자가 포트폴리오를 좋아했습니다.', '/app/14/item/314', FALSE, NULL),



(315, 15, 'BOOKMARK', '보관됨 315', '포트폴리오가 저장되었습니다.', '/app/15/item/315', FALSE, NULL),



(316, 16, 'COMMENT', '회의 316', '새 코멘트가 도착했습니다.', '/app/16/item/316', TRUE, '2026-06-09 11:00:00'),



(317, 17, 'AI', 'AI 317', '아이 검수가 완료되었습니다.', '/app/17/item/317', FALSE, NULL),



(318, 18, 'SYSTEM', '시스템 318', '시스템 상태가 업데이트되었습니다.', '/app/18/item/318', FALSE, NULL),



(319, 19, 'MESSAGE', '새 메시지 319', '새 메시지가 도착했습니다.', '/app/19/item/319', FALSE, NULL),



(320, 20, 'LIKE', '좋아요 320', '사용자가 포트폴리오를 좋아했습니다.', '/app/20/item/320', TRUE, '2026-06-13 11:00:00'),



(321, 21, 'BOOKMARK', '보관됨 321', '포트폴리오가 저장되었습니다.', '/app/21/item/321', FALSE, NULL),



(322, 22, 'COMMENT', '회의 322', '새 코멘트가 도착했습니다.', '/app/22/item/322', FALSE, NULL),



(323, 23, 'AI', 'AI 323', '아이 검수가 완료되었습니다.', '/app/23/item/323', FALSE, NULL),



(324, 24, 'SYSTEM', '시스템 324', '시스템 상태가 업데이트되었습니다.', '/app/24/item/324', TRUE, '2026-06-17 11:00:00'),



(325, 25, 'MESSAGE', '새 메시지 325', '새 메시지가 도착했습니다.', '/app/25/item/325', FALSE, NULL),



(326, 26, 'LIKE', '좋아요 326', '사용자가 포트폴리오를 좋아했습니다.', '/app/26/item/326', FALSE, NULL),



(327, 27, 'BOOKMARK', '보관됨 327', '포트폴리오가 저장되었습니다.', '/app/27/item/327', FALSE, NULL),



(328, 28, 'COMMENT', '회의 328', '새 코멘트가 도착했습니다.', '/app/28/item/328', TRUE, '2026-06-21 11:00:00'),



(329, 29, 'AI', 'AI 329', '아이 검수가 완료되었습니다.', '/app/29/item/329', FALSE, NULL),



(330, 30, 'SYSTEM', '시스템 330', '시스템 상태가 업데이트되었습니다.', '/app/30/item/330', FALSE, NULL),



(331, 1, 'MESSAGE', '새 메시지 331', '새 메시지가 도착했습니다.', '/app/1/item/331', FALSE, NULL),



(332, 2, 'LIKE', '좋아요 332', '사용자가 포트폴리오를 좋아했습니다.', '/app/2/item/332', TRUE, '2026-06-25 11:00:00'),



(333, 3, 'BOOKMARK', '보관됨 333', '포트폴리오가 저장되었습니다.', '/app/3/item/333', FALSE, NULL),



(334, 4, 'COMMENT', '회의 334', '새 코멘트가 도착했습니다.', '/app/4/item/334', FALSE, NULL),



(335, 5, 'AI', 'AI 335', '아이 검수가 완료되었습니다.', '/app/5/item/335', FALSE, NULL),



(336, 6, 'SYSTEM', '시스템 336', '시스템 상태가 업데이트되었습니다.', '/app/6/item/336', TRUE, '2026-06-01 11:00:00'),



(337, 7, 'MESSAGE', '새 메시지 337', '새 메시지가 도착했습니다.', '/app/7/item/337', FALSE, NULL),



(338, 8, 'LIKE', '좋아요 338', '사용자가 포트폴리오를 좋아했습니다.', '/app/8/item/338', FALSE, NULL),



(339, 9, 'BOOKMARK', '보관됨 339', '포트폴리오가 저장되었습니다.', '/app/9/item/339', FALSE, NULL),



(340, 10, 'COMMENT', '회의 340', '새 코멘트가 도착했습니다.', '/app/10/item/340', TRUE, '2026-06-05 11:00:00'),



(341, 11, 'AI', 'AI 341', '아이 검수가 완료되었습니다.', '/app/11/item/341', FALSE, NULL),



(342, 12, 'SYSTEM', '시스템 342', '시스템 상태가 업데이트되었습니다.', '/app/12/item/342', FALSE, NULL),



(343, 13, 'MESSAGE', '새 메시지 343', '새 메시지가 도착했습니다.', '/app/13/item/343', FALSE, NULL),



(344, 14, 'LIKE', '좋아요 344', '사용자가 포트폴리오를 좋아했습니다.', '/app/14/item/344', TRUE, '2026-06-09 11:00:00'),



(345, 15, 'BOOKMARK', '보관됨 345', '포트폴리오가 저장되었습니다.', '/app/15/item/345', FALSE, NULL),



(346, 16, 'COMMENT', '회의 346', '새 코멘트가 도착했습니다.', '/app/16/item/346', FALSE, NULL),



(347, 17, 'AI', 'AI 347', '아이 검수가 완료되었습니다.', '/app/17/item/347', FALSE, NULL),



(348, 18, 'SYSTEM', '시스템 348', '시스템 상태가 업데이트되었습니다.', '/app/18/item/348', TRUE, '2026-06-13 11:00:00'),



(349, 19, 'MESSAGE', '새 메시지 349', '새 메시지가 도착했습니다.', '/app/19/item/349', FALSE, NULL),



(350, 20, 'LIKE', '좋아요 350', '사용자가 포트폴리오를 좋아했습니다.', '/app/20/item/350', FALSE, NULL),



(351, 21, 'BOOKMARK', '보관됨 351', '포트폴리오가 저장되었습니다.', '/app/21/item/351', FALSE, NULL),



(352, 22, 'COMMENT', '회의 352', '새 코멘트가 도착했습니다.', '/app/22/item/352', TRUE, '2026-06-17 11:00:00'),



(353, 23, 'AI', 'AI 353', '아이 검수가 완료되었습니다.', '/app/23/item/353', FALSE, NULL),



(354, 24, 'SYSTEM', '시스템 354', '시스템 상태가 업데이트되었습니다.', '/app/24/item/354', FALSE, NULL),



(355, 25, 'MESSAGE', '새 메시지 355', '새 메시지가 도착했습니다.', '/app/25/item/355', FALSE, NULL),



(356, 26, 'LIKE', '좋아요 356', '사용자가 포트폴리오를 좋아했습니다.', '/app/26/item/356', TRUE, '2026-06-21 11:00:00'),



(357, 27, 'BOOKMARK', '보관됨 357', '포트폴리오가 저장되었습니다.', '/app/27/item/357', FALSE, NULL),



(358, 28, 'COMMENT', '회의 358', '새 코멘트가 도착했습니다.', '/app/28/item/358', FALSE, NULL),



(359, 29, 'AI', 'AI 359', '아이 검수가 완료되었습니다.', '/app/29/item/359', FALSE, NULL),



(360, 30, 'SYSTEM', '시스템 360', '시스템 상태가 업데이트되었습니다.', '/app/30/item/360', TRUE, '2026-06-25 11:00:00'),



(361, 1, 'MESSAGE', '새 메시지 361', '새 메시지가 도착했습니다.', '/app/1/item/361', FALSE, NULL),



(362, 2, 'LIKE', '좋아요 362', '사용자가 포트폴리오를 좋아했습니다.', '/app/2/item/362', FALSE, NULL),



(363, 3, 'BOOKMARK', '보관됨 363', '포트폴리오가 저장되었습니다.', '/app/3/item/363', FALSE, NULL),



(364, 4, 'COMMENT', '회의 364', '새 코멘트가 도착했습니다.', '/app/4/item/364', TRUE, '2026-06-01 11:00:00'),



(365, 5, 'AI', 'AI 365', '아이 검수가 완료되었습니다.', '/app/5/item/365', FALSE, NULL),



(366, 6, 'SYSTEM', '시스템 366', '시스템 상태가 업데이트되었습니다.', '/app/6/item/366', FALSE, NULL),



(367, 7, 'MESSAGE', '새 메시지 367', '새 메시지가 도착했습니다.', '/app/7/item/367', FALSE, NULL),



(368, 8, 'LIKE', '좋아요 368', '사용자가 포트폴리오를 좋아했습니다.', '/app/8/item/368', TRUE, '2026-06-05 11:00:00'),



(369, 9, 'BOOKMARK', '보관됨 369', '포트폴리오가 저장되었습니다.', '/app/9/item/369', FALSE, NULL),



(370, 10, 'COMMENT', '회의 370', '새 코멘트가 도착했습니다.', '/app/10/item/370', FALSE, NULL),



(371, 11, 'AI', 'AI 371', '아이 검수가 완료되었습니다.', '/app/11/item/371', FALSE, NULL),



(372, 12, 'SYSTEM', '시스템 372', '시스템 상태가 업데이트되었습니다.', '/app/12/item/372', TRUE, '2026-06-09 11:00:00'),



(373, 13, 'MESSAGE', '새 메시지 373', '새 메시지가 도착했습니다.', '/app/13/item/373', FALSE, NULL),



(374, 14, 'LIKE', '좋아요 374', '사용자가 포트폴리오를 좋아했습니다.', '/app/14/item/374', FALSE, NULL),



(375, 15, 'BOOKMARK', '보관됨 375', '포트폴리오가 저장되었습니다.', '/app/15/item/375', FALSE, NULL),



(376, 16, 'COMMENT', '회의 376', '새 코멘트가 도착했습니다.', '/app/16/item/376', TRUE, '2026-06-13 11:00:00'),



(377, 17, 'AI', 'AI 377', '아이 검수가 완료되었습니다.', '/app/17/item/377', FALSE, NULL),



(378, 18, 'SYSTEM', '시스템 378', '시스템 상태가 업데이트되었습니다.', '/app/18/item/378', FALSE, NULL),



(379, 19, 'MESSAGE', '새 메시지 379', '새 메시지가 도착했습니다.', '/app/19/item/379', FALSE, NULL),



(380, 20, 'LIKE', '좋아요 380', '사용자가 포트폴리오를 좋아했습니다.', '/app/20/item/380', TRUE, '2026-06-17 11:00:00'),



(381, 21, 'BOOKMARK', '보관됨 381', '포트폴리오가 저장되었습니다.', '/app/21/item/381', FALSE, NULL),



(382, 22, 'COMMENT', '회의 382', '새 코멘트가 도착했습니다.', '/app/22/item/382', FALSE, NULL),



(383, 23, 'AI', 'AI 383', '아이 검수가 완료되었습니다.', '/app/23/item/383', FALSE, NULL),



(384, 24, 'SYSTEM', '시스템 384', '시스템 상태가 업데이트되었습니다.', '/app/24/item/384', TRUE, '2026-06-21 11:00:00'),



(385, 25, 'MESSAGE', '새 메시지 385', '새 메시지가 도착했습니다.', '/app/25/item/385', FALSE, NULL),



(386, 26, 'LIKE', '좋아요 386', '사용자가 포트폴리오를 좋아했습니다.', '/app/26/item/386', FALSE, NULL),



(387, 27, 'BOOKMARK', '보관됨 387', '포트폴리오가 저장되었습니다.', '/app/27/item/387', FALSE, NULL),



(388, 28, 'COMMENT', '회의 388', '새 코멘트가 도착했습니다.', '/app/28/item/388', TRUE, '2026-06-25 11:00:00'),



(389, 29, 'AI', 'AI 389', '아이 검수가 완료되었습니다.', '/app/29/item/389', FALSE, NULL),



(390, 30, 'SYSTEM', '시스템 390', '시스템 상태가 업데이트되었습니다.', '/app/30/item/390', FALSE, NULL),



(391, 1, 'MESSAGE', '새 메시지 391', '새 메시지가 도착했습니다.', '/app/1/item/391', FALSE, NULL),



(392, 2, 'LIKE', '좋아요 392', '사용자가 포트폴리오를 좋아했습니다.', '/app/2/item/392', TRUE, '2026-06-01 11:00:00'),



(393, 3, 'BOOKMARK', '보관됨 393', '포트폴리오가 저장되었습니다.', '/app/3/item/393', FALSE, NULL),



(394, 4, 'COMMENT', '회의 394', '새 코멘트가 도착했습니다.', '/app/4/item/394', FALSE, NULL),



(395, 5, 'AI', 'AI 395', '아이 검수가 완료되었습니다.', '/app/5/item/395', FALSE, NULL),



(396, 6, 'SYSTEM', '시스템 396', '시스템 상태가 업데이트되었습니다.', '/app/6/item/396', TRUE, '2026-06-05 11:00:00'),



(397, 7, 'MESSAGE', '새 메시지 397', '새 메시지가 도착했습니다.', '/app/7/item/397', FALSE, NULL),



(398, 8, 'LIKE', '좋아요 398', '사용자가 포트폴리오를 좋아했습니다.', '/app/8/item/398', FALSE, NULL),



(399, 9, 'BOOKMARK', '보관됨 399', '포트폴리오가 저장되었습니다.', '/app/9/item/399', FALSE, NULL),



(400, 10, 'COMMENT', '회의 400', '새 코멘트가 도착했습니다.', '/app/10/item/400', TRUE, '2026-06-09 11:00:00');



INSERT INTO notifications (id, user_id, type, title, content, link_url, is_read, read_at) VALUES



(401, 11, 'AI', 'AI 401', '아이 검수가 완료되었습니다.', '/app/11/item/401', FALSE, NULL),



(402, 12, 'SYSTEM', '시스템 402', '시스템 상태가 업데이트되었습니다.', '/app/12/item/402', FALSE, NULL),



(403, 13, 'MESSAGE', '새 메시지 403', '새 메시지가 도착했습니다.', '/app/13/item/403', FALSE, NULL),



(404, 14, 'LIKE', '좋아요 404', '사용자가 포트폴리오를 좋아했습니다.', '/app/14/item/404', TRUE, '2026-06-13 11:00:00'),



(405, 15, 'BOOKMARK', '보관됨 405', '포트폴리오가 저장되었습니다.', '/app/15/item/405', FALSE, NULL),



(406, 16, 'COMMENT', '회의 406', '새 코멘트가 도착했습니다.', '/app/16/item/406', FALSE, NULL),



(407, 17, 'AI', 'AI 407', '아이 검수가 완료되었습니다.', '/app/17/item/407', FALSE, NULL),



(408, 18, 'SYSTEM', '시스템 408', '시스템 상태가 업데이트되었습니다.', '/app/18/item/408', TRUE, '2026-06-17 11:00:00'),



(409, 19, 'MESSAGE', '새 메시지 409', '새 메시지가 도착했습니다.', '/app/19/item/409', FALSE, NULL),



(410, 20, 'LIKE', '좋아요 410', '사용자가 포트폴리오를 좋아했습니다.', '/app/20/item/410', FALSE, NULL),



(411, 21, 'BOOKMARK', '보관됨 411', '포트폴리오가 저장되었습니다.', '/app/21/item/411', FALSE, NULL),



(412, 22, 'COMMENT', '회의 412', '새 코멘트가 도착했습니다.', '/app/22/item/412', TRUE, '2026-06-21 11:00:00'),



(413, 23, 'AI', 'AI 413', '아이 검수가 완료되었습니다.', '/app/23/item/413', FALSE, NULL),



(414, 24, 'SYSTEM', '시스템 414', '시스템 상태가 업데이트되었습니다.', '/app/24/item/414', FALSE, NULL),



(415, 25, 'MESSAGE', '새 메시지 415', '새 메시지가 도착했습니다.', '/app/25/item/415', FALSE, NULL),



(416, 26, 'LIKE', '좋아요 416', '사용자가 포트폴리오를 좋아했습니다.', '/app/26/item/416', TRUE, '2026-06-25 11:00:00'),



(417, 27, 'BOOKMARK', '보관됨 417', '포트폴리오가 저장되었습니다.', '/app/27/item/417', FALSE, NULL),



(418, 28, 'COMMENT', '회의 418', '새 코멘트가 도착했습니다.', '/app/28/item/418', FALSE, NULL),



(419, 29, 'AI', 'AI 419', '아이 검수가 완료되었습니다.', '/app/29/item/419', FALSE, NULL),



(420, 30, 'SYSTEM', '시스템 420', '시스템 상태가 업데이트되었습니다.', '/app/30/item/420', TRUE, '2026-06-01 11:00:00'),



(421, 1, 'MESSAGE', '새 메시지 421', '새 메시지가 도착했습니다.', '/app/1/item/421', FALSE, NULL),



(422, 2, 'LIKE', '좋아요 422', '사용자가 포트폴리오를 좋아했습니다.', '/app/2/item/422', FALSE, NULL),



(423, 3, 'BOOKMARK', '보관됨 423', '포트폴리오가 저장되었습니다.', '/app/3/item/423', FALSE, NULL),



(424, 4, 'COMMENT', '회의 424', '새 코멘트가 도착했습니다.', '/app/4/item/424', TRUE, '2026-06-05 11:00:00'),



(425, 5, 'AI', 'AI 425', '아이 검수가 완료되었습니다.', '/app/5/item/425', FALSE, NULL),



(426, 6, 'SYSTEM', '시스템 426', '시스템 상태가 업데이트되었습니다.', '/app/6/item/426', FALSE, NULL),



(427, 7, 'MESSAGE', '새 메시지 427', '새 메시지가 도착했습니다.', '/app/7/item/427', FALSE, NULL),



(428, 8, 'LIKE', '좋아요 428', '사용자가 포트폴리오를 좋아했습니다.', '/app/8/item/428', TRUE, '2026-06-09 11:00:00'),



(429, 9, 'BOOKMARK', '보관됨 429', '포트폴리오가 저장되었습니다.', '/app/9/item/429', FALSE, NULL),



(430, 10, 'COMMENT', '회의 430', '새 코멘트가 도착했습니다.', '/app/10/item/430', FALSE, NULL),



(431, 11, 'AI', 'AI 431', '아이 검수가 완료되었습니다.', '/app/11/item/431', FALSE, NULL),



(432, 12, 'SYSTEM', '시스템 432', '시스템 상태가 업데이트되었습니다.', '/app/12/item/432', TRUE, '2026-06-13 11:00:00'),



(433, 13, 'MESSAGE', '새 메시지 433', '새 메시지가 도착했습니다.', '/app/13/item/433', FALSE, NULL),



(434, 14, 'LIKE', '좋아요 434', '사용자가 포트폴리오를 좋아했습니다.', '/app/14/item/434', FALSE, NULL),



(435, 15, 'BOOKMARK', '보관됨 435', '포트폴리오가 저장되었습니다.', '/app/15/item/435', FALSE, NULL),



(436, 16, 'COMMENT', '회의 436', '새 코멘트가 도착했습니다.', '/app/16/item/436', TRUE, '2026-06-17 11:00:00'),



(437, 17, 'AI', 'AI 437', '아이 검수가 완료되었습니다.', '/app/17/item/437', FALSE, NULL),



(438, 18, 'SYSTEM', '시스템 438', '시스템 상태가 업데이트되었습니다.', '/app/18/item/438', FALSE, NULL),



(439, 19, 'MESSAGE', '새 메시지 439', '새 메시지가 도착했습니다.', '/app/19/item/439', FALSE, NULL),



(440, 20, 'LIKE', '좋아요 440', '사용자가 포트폴리오를 좋아했습니다.', '/app/20/item/440', TRUE, '2026-06-21 11:00:00'),



(441, 21, 'BOOKMARK', '보관됨 441', '포트폴리오가 저장되었습니다.', '/app/21/item/441', FALSE, NULL),



(442, 22, 'COMMENT', '회의 442', '새 코멘트가 도착했습니다.', '/app/22/item/442', FALSE, NULL),



(443, 23, 'AI', 'AI 443', '아이 검수가 완료되었습니다.', '/app/23/item/443', FALSE, NULL),



(444, 24, 'SYSTEM', '시스템 444', '시스템 상태가 업데이트되었습니다.', '/app/24/item/444', TRUE, '2026-06-25 11:00:00'),



(445, 25, 'MESSAGE', '새 메시지 445', '새 메시지가 도착했습니다.', '/app/25/item/445', FALSE, NULL),



(446, 26, 'LIKE', '좋아요 446', '사용자가 포트폴리오를 좋아했습니다.', '/app/26/item/446', FALSE, NULL),



(447, 27, 'BOOKMARK', '보관됨 447', '포트폴리오가 저장되었습니다.', '/app/27/item/447', FALSE, NULL),



(448, 28, 'COMMENT', '회의 448', '새 코멘트가 도착했습니다.', '/app/28/item/448', TRUE, '2026-06-01 11:00:00'),



(449, 29, 'AI', 'AI 449', '아이 검수가 완료되었습니다.', '/app/29/item/449', FALSE, NULL),



(450, 30, 'SYSTEM', '시스템 450', '시스템 상태가 업데이트되었습니다.', '/app/30/item/450', FALSE, NULL),



(451, 1, 'MESSAGE', '새 메시지 451', '새 메시지가 도착했습니다.', '/app/1/item/451', FALSE, NULL),



(452, 2, 'LIKE', '좋아요 452', '사용자가 포트폴리오를 좋아했습니다.', '/app/2/item/452', TRUE, '2026-06-05 11:00:00'),



(453, 3, 'BOOKMARK', '보관됨 453', '포트폴리오가 저장되었습니다.', '/app/3/item/453', FALSE, NULL),



(454, 4, 'COMMENT', '회의 454', '새 코멘트가 도착했습니다.', '/app/4/item/454', FALSE, NULL),



(455, 5, 'AI', 'AI 455', '아이 검수가 완료되었습니다.', '/app/5/item/455', FALSE, NULL),



(456, 6, 'SYSTEM', '시스템 456', '시스템 상태가 업데이트되었습니다.', '/app/6/item/456', TRUE, '2026-06-09 11:00:00'),



(457, 7, 'MESSAGE', '새 메시지 457', '새 메시지가 도착했습니다.', '/app/7/item/457', FALSE, NULL),



(458, 8, 'LIKE', '좋아요 458', '사용자가 포트폴리오를 좋아했습니다.', '/app/8/item/458', FALSE, NULL),



(459, 9, 'BOOKMARK', '보관됨 459', '포트폴리오가 저장되었습니다.', '/app/9/item/459', FALSE, NULL),



(460, 10, 'COMMENT', '회의 460', '새 코멘트가 도착했습니다.', '/app/10/item/460', TRUE, '2026-06-13 11:00:00'),



(461, 11, 'AI', 'AI 461', '아이 검수가 완료되었습니다.', '/app/11/item/461', FALSE, NULL),



(462, 12, 'SYSTEM', '시스템 462', '시스템 상태가 업데이트되었습니다.', '/app/12/item/462', FALSE, NULL),



(463, 13, 'MESSAGE', '새 메시지 463', '새 메시지가 도착했습니다.', '/app/13/item/463', FALSE, NULL),



(464, 14, 'LIKE', '좋아요 464', '사용자가 포트폴리오를 좋아했습니다.', '/app/14/item/464', TRUE, '2026-06-17 11:00:00'),



(465, 15, 'BOOKMARK', '보관됨 465', '포트폴리오가 저장되었습니다.', '/app/15/item/465', FALSE, NULL),



(466, 16, 'COMMENT', '회의 466', '새 코멘트가 도착했습니다.', '/app/16/item/466', FALSE, NULL),



(467, 17, 'AI', 'AI 467', '아이 검수가 완료되었습니다.', '/app/17/item/467', FALSE, NULL),



(468, 18, 'SYSTEM', '시스템 468', '시스템 상태가 업데이트되었습니다.', '/app/18/item/468', TRUE, '2026-06-21 11:00:00'),



(469, 19, 'MESSAGE', '새 메시지 469', '새 메시지가 도착했습니다.', '/app/19/item/469', FALSE, NULL),



(470, 20, 'LIKE', '좋아요 470', '사용자가 포트폴리오를 좋아했습니다.', '/app/20/item/470', FALSE, NULL),



(471, 21, 'BOOKMARK', '보관됨 471', '포트폴리오가 저장되었습니다.', '/app/21/item/471', FALSE, NULL),



(472, 22, 'COMMENT', '회의 472', '새 코멘트가 도착했습니다.', '/app/22/item/472', TRUE, '2026-06-25 11:00:00'),



(473, 23, 'AI', 'AI 473', '아이 검수가 완료되었습니다.', '/app/23/item/473', FALSE, NULL),



(474, 24, 'SYSTEM', '시스템 474', '시스템 상태가 업데이트되었습니다.', '/app/24/item/474', FALSE, NULL),



(475, 25, 'MESSAGE', '새 메시지 475', '새 메시지가 도착했습니다.', '/app/25/item/475', FALSE, NULL),



(476, 26, 'LIKE', '좋아요 476', '사용자가 포트폴리오를 좋아했습니다.', '/app/26/item/476', TRUE, '2026-06-01 11:00:00'),



(477, 27, 'BOOKMARK', '보관됨 477', '포트폴리오가 저장되었습니다.', '/app/27/item/477', FALSE, NULL),



(478, 28, 'COMMENT', '회의 478', '새 코멘트가 도착했습니다.', '/app/28/item/478', FALSE, NULL),



(479, 29, 'AI', 'AI 479', '아이 검수가 완료되었습니다.', '/app/29/item/479', FALSE, NULL),



(480, 30, 'SYSTEM', '시스템 480', '시스템 상태가 업데이트되었습니다.', '/app/30/item/480', TRUE, '2026-06-05 11:00:00'),



(481, 1, 'MESSAGE', '새 메시지 481', '새 메시지가 도착했습니다.', '/app/1/item/481', FALSE, NULL),



(482, 2, 'LIKE', '좋아요 482', '사용자가 포트폴리오를 좋아했습니다.', '/app/2/item/482', FALSE, NULL),



(483, 3, 'BOOKMARK', '보관됨 483', '포트폴리오가 저장되었습니다.', '/app/3/item/483', FALSE, NULL),



(484, 4, 'COMMENT', '회의 484', '새 코멘트가 도착했습니다.', '/app/4/item/484', TRUE, '2026-06-09 11:00:00'),



(485, 5, 'AI', 'AI 485', '아이 검수가 완료되었습니다.', '/app/5/item/485', FALSE, NULL),



(486, 6, 'SYSTEM', '시스템 486', '시스템 상태가 업데이트되었습니다.', '/app/6/item/486', FALSE, NULL),



(487, 7, 'MESSAGE', '새 메시지 487', '새 메시지가 도착했습니다.', '/app/7/item/487', FALSE, NULL),



(488, 8, 'LIKE', '좋아요 488', '사용자가 포트폴리오를 좋아했습니다.', '/app/8/item/488', TRUE, '2026-06-13 11:00:00'),



(489, 9, 'BOOKMARK', '보관됨 489', '포트폴리오가 저장되었습니다.', '/app/9/item/489', FALSE, NULL),



(490, 10, 'COMMENT', '회의 490', '새 코멘트가 도착했습니다.', '/app/10/item/490', FALSE, NULL),



(491, 11, 'AI', 'AI 491', '아이 검수가 완료되었습니다.', '/app/11/item/491', FALSE, NULL),



(492, 12, 'SYSTEM', '시스템 492', '시스템 상태가 업데이트되었습니다.', '/app/12/item/492', TRUE, '2026-06-17 11:00:00'),



(493, 13, 'MESSAGE', '새 메시지 493', '새 메시지가 도착했습니다.', '/app/13/item/493', FALSE, NULL),



(494, 14, 'LIKE', '좋아요 494', '사용자가 포트폴리오를 좋아했습니다.', '/app/14/item/494', FALSE, NULL),



(495, 15, 'BOOKMARK', '보관됨 495', '포트폴리오가 저장되었습니다.', '/app/15/item/495', FALSE, NULL),



(496, 16, 'COMMENT', '회의 496', '새 코멘트가 도착했습니다.', '/app/16/item/496', TRUE, '2026-06-21 11:00:00'),



(497, 17, 'AI', 'AI 497', '아이 검수가 완료되었습니다.', '/app/17/item/497', FALSE, NULL),



(498, 18, 'SYSTEM', '시스템 498', '시스템 상태가 업데이트되었습니다.', '/app/18/item/498', FALSE, NULL),



(499, 19, 'MESSAGE', '새 메시지 499', '새 메시지가 도착했습니다.', '/app/19/item/499', FALSE, NULL),



(500, 20, 'LIKE', '좋아요 500', '사용자가 포트폴리오를 좋아했습니다.', '/app/20/item/500', TRUE, '2026-06-25 11:00:00'),



(501, 21, 'BOOKMARK', '보관됨 501', '포트폴리오가 저장되었습니다.', '/app/21/item/501', FALSE, NULL),



(502, 22, 'COMMENT', '회의 502', '새 코멘트가 도착했습니다.', '/app/22/item/502', FALSE, NULL),



(503, 23, 'AI', 'AI 503', '아이 검수가 완료되었습니다.', '/app/23/item/503', FALSE, NULL),



(504, 24, 'SYSTEM', '시스템 504', '시스템 상태가 업데이트되었습니다.', '/app/24/item/504', TRUE, '2026-06-01 11:00:00'),



(505, 25, 'MESSAGE', '새 메시지 505', '새 메시지가 도착했습니다.', '/app/25/item/505', FALSE, NULL),



(506, 26, 'LIKE', '좋아요 506', '사용자가 포트폴리오를 좋아했습니다.', '/app/26/item/506', FALSE, NULL),



(507, 27, 'BOOKMARK', '보관됨 507', '포트폴리오가 저장되었습니다.', '/app/27/item/507', FALSE, NULL),



(508, 28, 'COMMENT', '회의 508', '새 코멘트가 도착했습니다.', '/app/28/item/508', TRUE, '2026-06-05 11:00:00'),



(509, 29, 'AI', 'AI 509', '아이 검수가 완료되었습니다.', '/app/29/item/509', FALSE, NULL),



(510, 30, 'SYSTEM', '시스템 510', '시스템 상태가 업데이트되었습니다.', '/app/30/item/510', FALSE, NULL),



(511, 1, 'MESSAGE', '새 메시지 511', '새 메시지가 도착했습니다.', '/app/1/item/511', FALSE, NULL),



(512, 2, 'LIKE', '좋아요 512', '사용자가 포트폴리오를 좋아했습니다.', '/app/2/item/512', TRUE, '2026-06-09 11:00:00'),



(513, 3, 'BOOKMARK', '보관됨 513', '포트폴리오가 저장되었습니다.', '/app/3/item/513', FALSE, NULL),



(514, 4, 'COMMENT', '회의 514', '새 코멘트가 도착했습니다.', '/app/4/item/514', FALSE, NULL),



(515, 5, 'AI', 'AI 515', '아이 검수가 완료되었습니다.', '/app/5/item/515', FALSE, NULL),



(516, 6, 'SYSTEM', '시스템 516', '시스템 상태가 업데이트되었습니다.', '/app/6/item/516', TRUE, '2026-06-13 11:00:00'),



(517, 7, 'MESSAGE', '새 메시지 517', '새 메시지가 도착했습니다.', '/app/7/item/517', FALSE, NULL),



(518, 8, 'LIKE', '좋아요 518', '사용자가 포트폴리오를 좋아했습니다.', '/app/8/item/518', FALSE, NULL),



(519, 9, 'BOOKMARK', '보관됨 519', '포트폴리오가 저장되었습니다.', '/app/9/item/519', FALSE, NULL),



(520, 10, 'COMMENT', '회의 520', '새 코멘트가 도착했습니다.', '/app/10/item/520', TRUE, '2026-06-17 11:00:00'),



(521, 11, 'AI', 'AI 521', '아이 검수가 완료되었습니다.', '/app/11/item/521', FALSE, NULL),



(522, 12, 'SYSTEM', '시스템 522', '시스템 상태가 업데이트되었습니다.', '/app/12/item/522', FALSE, NULL),



(523, 13, 'MESSAGE', '새 메시지 523', '새 메시지가 도착했습니다.', '/app/13/item/523', FALSE, NULL),



(524, 14, 'LIKE', '좋아요 524', '사용자가 포트폴리오를 좋아했습니다.', '/app/14/item/524', TRUE, '2026-06-21 11:00:00'),



(525, 15, 'BOOKMARK', '보관됨 525', '포트폴리오가 저장되었습니다.', '/app/15/item/525', FALSE, NULL),



(526, 16, 'COMMENT', '회의 526', '새 코멘트가 도착했습니다.', '/app/16/item/526', FALSE, NULL),



(527, 17, 'AI', 'AI 527', '아이 검수가 완료되었습니다.', '/app/17/item/527', FALSE, NULL),



(528, 18, 'SYSTEM', '시스템 528', '시스템 상태가 업데이트되었습니다.', '/app/18/item/528', TRUE, '2026-06-25 11:00:00'),



(529, 19, 'MESSAGE', '새 메시지 529', '새 메시지가 도착했습니다.', '/app/19/item/529', FALSE, NULL),



(530, 20, 'LIKE', '좋아요 530', '사용자가 포트폴리오를 좋아했습니다.', '/app/20/item/530', FALSE, NULL),



(531, 21, 'BOOKMARK', '보관됨 531', '포트폴리오가 저장되었습니다.', '/app/21/item/531', FALSE, NULL),



(532, 22, 'COMMENT', '회의 532', '새 코멘트가 도착했습니다.', '/app/22/item/532', TRUE, '2026-06-01 11:00:00'),



(533, 23, 'AI', 'AI 533', '아이 검수가 완료되었습니다.', '/app/23/item/533', FALSE, NULL),



(534, 24, 'SYSTEM', '시스템 534', '시스템 상태가 업데이트되었습니다.', '/app/24/item/534', FALSE, NULL),



(535, 25, 'MESSAGE', '새 메시지 535', '새 메시지가 도착했습니다.', '/app/25/item/535', FALSE, NULL),



(536, 26, 'LIKE', '좋아요 536', '사용자가 포트폴리오를 좋아했습니다.', '/app/26/item/536', TRUE, '2026-06-05 11:00:00'),



(537, 27, 'BOOKMARK', '보관됨 537', '포트폴리오가 저장되었습니다.', '/app/27/item/537', FALSE, NULL),



(538, 28, 'COMMENT', '회의 538', '새 코멘트가 도착했습니다.', '/app/28/item/538', FALSE, NULL),



(539, 29, 'AI', 'AI 539', '아이 검수가 완료되었습니다.', '/app/29/item/539', FALSE, NULL),



(540, 30, 'SYSTEM', '시스템 540', '시스템 상태가 업데이트되었습니다.', '/app/30/item/540', TRUE, '2026-06-09 11:00:00'),



(541, 1, 'MESSAGE', '새 메시지 541', '새 메시지가 도착했습니다.', '/app/1/item/541', FALSE, NULL),



(542, 2, 'LIKE', '좋아요 542', '사용자가 포트폴리오를 좋아했습니다.', '/app/2/item/542', FALSE, NULL),



(543, 3, 'BOOKMARK', '보관됨 543', '포트폴리오가 저장되었습니다.', '/app/3/item/543', FALSE, NULL),



(544, 4, 'COMMENT', '회의 544', '새 코멘트가 도착했습니다.', '/app/4/item/544', TRUE, '2026-06-13 11:00:00'),



(545, 5, 'AI', 'AI 545', '아이 검수가 완료되었습니다.', '/app/5/item/545', FALSE, NULL),



(546, 6, 'SYSTEM', '시스템 546', '시스템 상태가 업데이트되었습니다.', '/app/6/item/546', FALSE, NULL),



(547, 7, 'MESSAGE', '새 메시지 547', '새 메시지가 도착했습니다.', '/app/7/item/547', FALSE, NULL),



(548, 8, 'LIKE', '좋아요 548', '사용자가 포트폴리오를 좋아했습니다.', '/app/8/item/548', TRUE, '2026-06-17 11:00:00'),



(549, 9, 'BOOKMARK', '보관됨 549', '포트폴리오가 저장되었습니다.', '/app/9/item/549', FALSE, NULL),



(550, 10, 'COMMENT', '회의 550', '새 코멘트가 도착했습니다.', '/app/10/item/550', FALSE, NULL),



(551, 11, 'AI', 'AI 551', '아이 검수가 완료되었습니다.', '/app/11/item/551', FALSE, NULL),



(552, 12, 'SYSTEM', '시스템 552', '시스템 상태가 업데이트되었습니다.', '/app/12/item/552', TRUE, '2026-06-21 11:00:00'),



(553, 13, 'MESSAGE', '새 메시지 553', '새 메시지가 도착했습니다.', '/app/13/item/553', FALSE, NULL),



(554, 14, 'LIKE', '좋아요 554', '사용자가 포트폴리오를 좋아했습니다.', '/app/14/item/554', FALSE, NULL),



(555, 15, 'BOOKMARK', '보관됨 555', '포트폴리오가 저장되었습니다.', '/app/15/item/555', FALSE, NULL),



(556, 16, 'COMMENT', '회의 556', '새 코멘트가 도착했습니다.', '/app/16/item/556', TRUE, '2026-06-25 11:00:00'),



(557, 17, 'AI', 'AI 557', '아이 검수가 완료되었습니다.', '/app/17/item/557', FALSE, NULL),



(558, 18, 'SYSTEM', '시스템 558', '시스템 상태가 업데이트되었습니다.', '/app/18/item/558', FALSE, NULL),



(559, 19, 'MESSAGE', '새 메시지 559', '새 메시지가 도착했습니다.', '/app/19/item/559', FALSE, NULL),



(560, 20, 'LIKE', '좋아요 560', '사용자가 포트폴리오를 좋아했습니다.', '/app/20/item/560', TRUE, '2026-06-01 11:00:00'),



(561, 21, 'BOOKMARK', '보관됨 561', '포트폴리오가 저장되었습니다.', '/app/21/item/561', FALSE, NULL),



(562, 22, 'COMMENT', '회의 562', '새 코멘트가 도착했습니다.', '/app/22/item/562', FALSE, NULL),



(563, 23, 'AI', 'AI 563', '아이 검수가 완료되었습니다.', '/app/23/item/563', FALSE, NULL),



(564, 24, 'SYSTEM', '시스템 564', '시스템 상태가 업데이트되었습니다.', '/app/24/item/564', TRUE, '2026-06-05 11:00:00'),



(565, 25, 'MESSAGE', '새 메시지 565', '새 메시지가 도착했습니다.', '/app/25/item/565', FALSE, NULL),



(566, 26, 'LIKE', '좋아요 566', '사용자가 포트폴리오를 좋아했습니다.', '/app/26/item/566', FALSE, NULL),



(567, 27, 'BOOKMARK', '보관됨 567', '포트폴리오가 저장되었습니다.', '/app/27/item/567', FALSE, NULL),



(568, 28, 'COMMENT', '회의 568', '새 코멘트가 도착했습니다.', '/app/28/item/568', TRUE, '2026-06-09 11:00:00'),



(569, 29, 'AI', 'AI 569', '아이 검수가 완료되었습니다.', '/app/29/item/569', FALSE, NULL),



(570, 30, 'SYSTEM', '시스템 570', '시스템 상태가 업데이트되었습니다.', '/app/30/item/570', FALSE, NULL),



(571, 1, 'MESSAGE', '새 메시지 571', '새 메시지가 도착했습니다.', '/app/1/item/571', FALSE, NULL),



(572, 2, 'LIKE', '좋아요 572', '사용자가 포트폴리오를 좋아했습니다.', '/app/2/item/572', TRUE, '2026-06-13 11:00:00'),



(573, 3, 'BOOKMARK', '보관됨 573', '포트폴리오가 저장되었습니다.', '/app/3/item/573', FALSE, NULL),



(574, 4, 'COMMENT', '회의 574', '새 코멘트가 도착했습니다.', '/app/4/item/574', FALSE, NULL),



(575, 5, 'AI', 'AI 575', '아이 검수가 완료되었습니다.', '/app/5/item/575', FALSE, NULL),



(576, 6, 'SYSTEM', '시스템 576', '시스템 상태가 업데이트되었습니다.', '/app/6/item/576', TRUE, '2026-06-17 11:00:00'),



(577, 7, 'MESSAGE', '새 메시지 577', '새 메시지가 도착했습니다.', '/app/7/item/577', FALSE, NULL),



(578, 8, 'LIKE', '좋아요 578', '사용자가 포트폴리오를 좋아했습니다.', '/app/8/item/578', FALSE, NULL),



(579, 9, 'BOOKMARK', '보관됨 579', '포트폴리오가 저장되었습니다.', '/app/9/item/579', FALSE, NULL),



(580, 10, 'COMMENT', '회의 580', '새 코멘트가 도착했습니다.', '/app/10/item/580', TRUE, '2026-06-21 11:00:00'),



(581, 11, 'AI', 'AI 581', '아이 검수가 완료되었습니다.', '/app/11/item/581', FALSE, NULL),



(582, 12, 'SYSTEM', '시스템 582', '시스템 상태가 업데이트되었습니다.', '/app/12/item/582', FALSE, NULL),



(583, 13, 'MESSAGE', '새 메시지 583', '새 메시지가 도착했습니다.', '/app/13/item/583', FALSE, NULL),



(584, 14, 'LIKE', '좋아요 584', '사용자가 포트폴리오를 좋아했습니다.', '/app/14/item/584', TRUE, '2026-06-25 11:00:00'),



(585, 15, 'BOOKMARK', '보관됨 585', '포트폴리오가 저장되었습니다.', '/app/15/item/585', FALSE, NULL),



(586, 16, 'COMMENT', '회의 586', '새 코멘트가 도착했습니다.', '/app/16/item/586', FALSE, NULL),



(587, 17, 'AI', 'AI 587', '아이 검수가 완료되었습니다.', '/app/17/item/587', FALSE, NULL),



(588, 18, 'SYSTEM', '시스템 588', '시스템 상태가 업데이트되었습니다.', '/app/18/item/588', TRUE, '2026-06-01 11:00:00'),



(589, 19, 'MESSAGE', '새 메시지 589', '새 메시지가 도착했습니다.', '/app/19/item/589', FALSE, NULL),



(590, 20, 'LIKE', '좋아요 590', '사용자가 포트폴리오를 좋아했습니다.', '/app/20/item/590', FALSE, NULL),



(591, 21, 'BOOKMARK', '보관됨 591', '포트폴리오가 저장되었습니다.', '/app/21/item/591', FALSE, NULL),



(592, 22, 'COMMENT', '회의 592', '새 코멘트가 도착했습니다.', '/app/22/item/592', TRUE, '2026-06-05 11:00:00'),



(593, 23, 'AI', 'AI 593', '아이 검수가 완료되었습니다.', '/app/23/item/593', FALSE, NULL),



(594, 24, 'SYSTEM', '시스템 594', '시스템 상태가 업데이트되었습니다.', '/app/24/item/594', FALSE, NULL),



(595, 25, 'MESSAGE', '새 메시지 595', '새 메시지가 도착했습니다.', '/app/25/item/595', FALSE, NULL),



(596, 26, 'LIKE', '좋아요 596', '사용자가 포트폴리오를 좋아했습니다.', '/app/26/item/596', TRUE, '2026-06-09 11:00:00'),



(597, 27, 'BOOKMARK', '보관됨 597', '포트폴리오가 저장되었습니다.', '/app/27/item/597', FALSE, NULL),



(598, 28, 'COMMENT', '회의 598', '새 코멘트가 도착했습니다.', '/app/28/item/598', FALSE, NULL),



(599, 29, 'AI', 'AI 599', '아이 검수가 완료되었습니다.', '/app/29/item/599', FALSE, NULL),



(600, 30, 'SYSTEM', '시스템 600', '시스템 상태가 업데이트되었습니다.', '/app/30/item/600', TRUE, '2026-06-13 11:00:00');



INSERT INTO notifications (id, user_id, type, title, content, link_url, is_read, read_at) VALUES



(601, 1, 'MESSAGE', '새 메시지 601', '새 메시지가 도착했습니다.', '/app/1/item/601', FALSE, NULL),



(602, 2, 'LIKE', '좋아요 602', '사용자가 포트폴리오를 좋아했습니다.', '/app/2/item/602', FALSE, NULL),



(603, 3, 'BOOKMARK', '보관됨 603', '포트폴리오가 저장되었습니다.', '/app/3/item/603', FALSE, NULL),



(604, 4, 'COMMENT', '회의 604', '새 코멘트가 도착했습니다.', '/app/4/item/604', TRUE, '2026-06-17 11:00:00'),



(605, 5, 'AI', 'AI 605', '아이 검수가 완료되었습니다.', '/app/5/item/605', FALSE, NULL),



(606, 6, 'SYSTEM', '시스템 606', '시스템 상태가 업데이트되었습니다.', '/app/6/item/606', FALSE, NULL),



(607, 7, 'MESSAGE', '새 메시지 607', '새 메시지가 도착했습니다.', '/app/7/item/607', FALSE, NULL),



(608, 8, 'LIKE', '좋아요 608', '사용자가 포트폴리오를 좋아했습니다.', '/app/8/item/608', TRUE, '2026-06-21 11:00:00'),



(609, 9, 'BOOKMARK', '보관됨 609', '포트폴리오가 저장되었습니다.', '/app/9/item/609', FALSE, NULL),



(610, 10, 'COMMENT', '회의 610', '새 코멘트가 도착했습니다.', '/app/10/item/610', FALSE, NULL),



(611, 11, 'AI', 'AI 611', '아이 검수가 완료되었습니다.', '/app/11/item/611', FALSE, NULL),



(612, 12, 'SYSTEM', '시스템 612', '시스템 상태가 업데이트되었습니다.', '/app/12/item/612', TRUE, '2026-06-25 11:00:00'),



(613, 13, 'MESSAGE', '새 메시지 613', '새 메시지가 도착했습니다.', '/app/13/item/613', FALSE, NULL),



(614, 14, 'LIKE', '좋아요 614', '사용자가 포트폴리오를 좋아했습니다.', '/app/14/item/614', FALSE, NULL),



(615, 15, 'BOOKMARK', '보관됨 615', '포트폴리오가 저장되었습니다.', '/app/15/item/615', FALSE, NULL),



(616, 16, 'COMMENT', '회의 616', '새 코멘트가 도착했습니다.', '/app/16/item/616', TRUE, '2026-06-01 11:00:00'),



(617, 17, 'AI', 'AI 617', '아이 검수가 완료되었습니다.', '/app/17/item/617', FALSE, NULL),



(618, 18, 'SYSTEM', '시스템 618', '시스템 상태가 업데이트되었습니다.', '/app/18/item/618', FALSE, NULL),



(619, 19, 'MESSAGE', '새 메시지 619', '새 메시지가 도착했습니다.', '/app/19/item/619', FALSE, NULL),



(620, 20, 'LIKE', '좋아요 620', '사용자가 포트폴리오를 좋아했습니다.', '/app/20/item/620', TRUE, '2026-06-05 11:00:00'),



(621, 21, 'BOOKMARK', '보관됨 621', '포트폴리오가 저장되었습니다.', '/app/21/item/621', FALSE, NULL),



(622, 22, 'COMMENT', '회의 622', '새 코멘트가 도착했습니다.', '/app/22/item/622', FALSE, NULL),



(623, 23, 'AI', 'AI 623', '아이 검수가 완료되었습니다.', '/app/23/item/623', FALSE, NULL),



(624, 24, 'SYSTEM', '시스템 624', '시스템 상태가 업데이트되었습니다.', '/app/24/item/624', TRUE, '2026-06-09 11:00:00'),



(625, 25, 'MESSAGE', '새 메시지 625', '새 메시지가 도착했습니다.', '/app/25/item/625', FALSE, NULL),



(626, 26, 'LIKE', '좋아요 626', '사용자가 포트폴리오를 좋아했습니다.', '/app/26/item/626', FALSE, NULL),



(627, 27, 'BOOKMARK', '보관됨 627', '포트폴리오가 저장되었습니다.', '/app/27/item/627', FALSE, NULL),



(628, 28, 'COMMENT', '회의 628', '새 코멘트가 도착했습니다.', '/app/28/item/628', TRUE, '2026-06-13 11:00:00'),



(629, 29, 'AI', 'AI 629', '아이 검수가 완료되었습니다.', '/app/29/item/629', FALSE, NULL),



(630, 30, 'SYSTEM', '시스템 630', '시스템 상태가 업데이트되었습니다.', '/app/30/item/630', FALSE, NULL),



(631, 1, 'MESSAGE', '새 메시지 631', '새 메시지가 도착했습니다.', '/app/1/item/631', FALSE, NULL),



(632, 2, 'LIKE', '좋아요 632', '사용자가 포트폴리오를 좋아했습니다.', '/app/2/item/632', TRUE, '2026-06-17 11:00:00'),



(633, 3, 'BOOKMARK', '보관됨 633', '포트폴리오가 저장되었습니다.', '/app/3/item/633', FALSE, NULL),



(634, 4, 'COMMENT', '회의 634', '새 코멘트가 도착했습니다.', '/app/4/item/634', FALSE, NULL),



(635, 5, 'AI', 'AI 635', '아이 검수가 완료되었습니다.', '/app/5/item/635', FALSE, NULL),



(636, 6, 'SYSTEM', '시스템 636', '시스템 상태가 업데이트되었습니다.', '/app/6/item/636', TRUE, '2026-06-21 11:00:00'),



(637, 7, 'MESSAGE', '새 메시지 637', '새 메시지가 도착했습니다.', '/app/7/item/637', FALSE, NULL),



(638, 8, 'LIKE', '좋아요 638', '사용자가 포트폴리오를 좋아했습니다.', '/app/8/item/638', FALSE, NULL),



(639, 9, 'BOOKMARK', '보관됨 639', '포트폴리오가 저장되었습니다.', '/app/9/item/639', FALSE, NULL),



(640, 10, 'COMMENT', '회의 640', '새 코멘트가 도착했습니다.', '/app/10/item/640', TRUE, '2026-06-25 11:00:00'),



(641, 11, 'AI', 'AI 641', '아이 검수가 완료되었습니다.', '/app/11/item/641', FALSE, NULL),



(642, 12, 'SYSTEM', '시스템 642', '시스템 상태가 업데이트되었습니다.', '/app/12/item/642', FALSE, NULL),



(643, 13, 'MESSAGE', '새 메시지 643', '새 메시지가 도착했습니다.', '/app/13/item/643', FALSE, NULL),



(644, 14, 'LIKE', '좋아요 644', '사용자가 포트폴리오를 좋아했습니다.', '/app/14/item/644', TRUE, '2026-06-01 11:00:00'),



(645, 15, 'BOOKMARK', '보관됨 645', '포트폴리오가 저장되었습니다.', '/app/15/item/645', FALSE, NULL),



(646, 16, 'COMMENT', '회의 646', '새 코멘트가 도착했습니다.', '/app/16/item/646', FALSE, NULL),



(647, 17, 'AI', 'AI 647', '아이 검수가 완료되었습니다.', '/app/17/item/647', FALSE, NULL),



(648, 18, 'SYSTEM', '시스템 648', '시스템 상태가 업데이트되었습니다.', '/app/18/item/648', TRUE, '2026-06-05 11:00:00'),



(649, 19, 'MESSAGE', '새 메시지 649', '새 메시지가 도착했습니다.', '/app/19/item/649', FALSE, NULL),



(650, 20, 'LIKE', '좋아요 650', '사용자가 포트폴리오를 좋아했습니다.', '/app/20/item/650', FALSE, NULL),



(651, 21, 'BOOKMARK', '보관됨 651', '포트폴리오가 저장되었습니다.', '/app/21/item/651', FALSE, NULL),



(652, 22, 'COMMENT', '회의 652', '새 코멘트가 도착했습니다.', '/app/22/item/652', TRUE, '2026-06-09 11:00:00'),



(653, 23, 'AI', 'AI 653', '아이 검수가 완료되었습니다.', '/app/23/item/653', FALSE, NULL),



(654, 24, 'SYSTEM', '시스템 654', '시스템 상태가 업데이트되었습니다.', '/app/24/item/654', FALSE, NULL),



(655, 25, 'MESSAGE', '새 메시지 655', '새 메시지가 도착했습니다.', '/app/25/item/655', FALSE, NULL),



(656, 26, 'LIKE', '좋아요 656', '사용자가 포트폴리오를 좋아했습니다.', '/app/26/item/656', TRUE, '2026-06-13 11:00:00'),



(657, 27, 'BOOKMARK', '보관됨 657', '포트폴리오가 저장되었습니다.', '/app/27/item/657', FALSE, NULL),



(658, 28, 'COMMENT', '회의 658', '새 코멘트가 도착했습니다.', '/app/28/item/658', FALSE, NULL),



(659, 29, 'AI', 'AI 659', '아이 검수가 완료되었습니다.', '/app/29/item/659', FALSE, NULL),



(660, 30, 'SYSTEM', '시스템 660', '시스템 상태가 업데이트되었습니다.', '/app/30/item/660', TRUE, '2026-06-17 11:00:00'),



(661, 1, 'MESSAGE', '새 메시지 661', '새 메시지가 도착했습니다.', '/app/1/item/661', FALSE, NULL),



(662, 2, 'LIKE', '좋아요 662', '사용자가 포트폴리오를 좋아했습니다.', '/app/2/item/662', FALSE, NULL),



(663, 3, 'BOOKMARK', '보관됨 663', '포트폴리오가 저장되었습니다.', '/app/3/item/663', FALSE, NULL),



(664, 4, 'COMMENT', '회의 664', '새 코멘트가 도착했습니다.', '/app/4/item/664', TRUE, '2026-06-21 11:00:00'),



(665, 5, 'AI', 'AI 665', '아이 검수가 완료되었습니다.', '/app/5/item/665', FALSE, NULL),



(666, 6, 'SYSTEM', '시스템 666', '시스템 상태가 업데이트되었습니다.', '/app/6/item/666', FALSE, NULL),



(667, 7, 'MESSAGE', '새 메시지 667', '새 메시지가 도착했습니다.', '/app/7/item/667', FALSE, NULL),



(668, 8, 'LIKE', '좋아요 668', '사용자가 포트폴리오를 좋아했습니다.', '/app/8/item/668', TRUE, '2026-06-25 11:00:00'),



(669, 9, 'BOOKMARK', '보관됨 669', '포트폴리오가 저장되었습니다.', '/app/9/item/669', FALSE, NULL),



(670, 10, 'COMMENT', '회의 670', '새 코멘트가 도착했습니다.', '/app/10/item/670', FALSE, NULL),



(671, 11, 'AI', 'AI 671', '아이 검수가 완료되었습니다.', '/app/11/item/671', FALSE, NULL),



(672, 12, 'SYSTEM', '시스템 672', '시스템 상태가 업데이트되었습니다.', '/app/12/item/672', TRUE, '2026-06-01 11:00:00'),



(673, 13, 'MESSAGE', '새 메시지 673', '새 메시지가 도착했습니다.', '/app/13/item/673', FALSE, NULL),



(674, 14, 'LIKE', '좋아요 674', '사용자가 포트폴리오를 좋아했습니다.', '/app/14/item/674', FALSE, NULL),



(675, 15, 'BOOKMARK', '보관됨 675', '포트폴리오가 저장되었습니다.', '/app/15/item/675', FALSE, NULL),



(676, 16, 'COMMENT', '회의 676', '새 코멘트가 도착했습니다.', '/app/16/item/676', TRUE, '2026-06-05 11:00:00'),



(677, 17, 'AI', 'AI 677', '아이 검수가 완료되었습니다.', '/app/17/item/677', FALSE, NULL),



(678, 18, 'SYSTEM', '시스템 678', '시스템 상태가 업데이트되었습니다.', '/app/18/item/678', FALSE, NULL),



(679, 19, 'MESSAGE', '새 메시지 679', '새 메시지가 도착했습니다.', '/app/19/item/679', FALSE, NULL),



(680, 20, 'LIKE', '좋아요 680', '사용자가 포트폴리오를 좋아했습니다.', '/app/20/item/680', TRUE, '2026-06-09 11:00:00'),



(681, 21, 'BOOKMARK', '보관됨 681', '포트폴리오가 저장되었습니다.', '/app/21/item/681', FALSE, NULL),



(682, 22, 'COMMENT', '회의 682', '새 코멘트가 도착했습니다.', '/app/22/item/682', FALSE, NULL),



(683, 23, 'AI', 'AI 683', '아이 검수가 완료되었습니다.', '/app/23/item/683', FALSE, NULL),



(684, 24, 'SYSTEM', '시스템 684', '시스템 상태가 업데이트되었습니다.', '/app/24/item/684', TRUE, '2026-06-13 11:00:00'),



(685, 25, 'MESSAGE', '새 메시지 685', '새 메시지가 도착했습니다.', '/app/25/item/685', FALSE, NULL),



(686, 26, 'LIKE', '좋아요 686', '사용자가 포트폴리오를 좋아했습니다.', '/app/26/item/686', FALSE, NULL),



(687, 27, 'BOOKMARK', '보관됨 687', '포트폴리오가 저장되었습니다.', '/app/27/item/687', FALSE, NULL),



(688, 28, 'COMMENT', '회의 688', '새 코멘트가 도착했습니다.', '/app/28/item/688', TRUE, '2026-06-17 11:00:00'),



(689, 29, 'AI', 'AI 689', '아이 검수가 완료되었습니다.', '/app/29/item/689', FALSE, NULL),



(690, 30, 'SYSTEM', '시스템 690', '시스템 상태가 업데이트되었습니다.', '/app/30/item/690', FALSE, NULL),



(691, 1, 'MESSAGE', '새 메시지 691', '새 메시지가 도착했습니다.', '/app/1/item/691', FALSE, NULL),



(692, 2, 'LIKE', '좋아요 692', '사용자가 포트폴리오를 좋아했습니다.', '/app/2/item/692', TRUE, '2026-06-21 11:00:00'),



(693, 3, 'BOOKMARK', '보관됨 693', '포트폴리오가 저장되었습니다.', '/app/3/item/693', FALSE, NULL),



(694, 4, 'COMMENT', '회의 694', '새 코멘트가 도착했습니다.', '/app/4/item/694', FALSE, NULL),



(695, 5, 'AI', 'AI 695', '아이 검수가 완료되었습니다.', '/app/5/item/695', FALSE, NULL),



(696, 6, 'SYSTEM', '시스템 696', '시스템 상태가 업데이트되었습니다.', '/app/6/item/696', TRUE, '2026-06-25 11:00:00'),



(697, 7, 'MESSAGE', '새 메시지 697', '새 메시지가 도착했습니다.', '/app/7/item/697', FALSE, NULL),



(698, 8, 'LIKE', '좋아요 698', '사용자가 포트폴리오를 좋아했습니다.', '/app/8/item/698', FALSE, NULL),



(699, 9, 'BOOKMARK', '보관됨 699', '포트폴리오가 저장되었습니다.', '/app/9/item/699', FALSE, NULL),



(700, 10, 'COMMENT', '회의 700', '새 코멘트가 도착했습니다.', '/app/10/item/700', TRUE, '2026-06-01 11:00:00'),



(701, 11, 'AI', 'AI 701', '아이 검수가 완료되었습니다.', '/app/11/item/701', FALSE, NULL),



(702, 12, 'SYSTEM', '시스템 702', '시스템 상태가 업데이트되었습니다.', '/app/12/item/702', FALSE, NULL),



(703, 13, 'MESSAGE', '새 메시지 703', '새 메시지가 도착했습니다.', '/app/13/item/703', FALSE, NULL),



(704, 14, 'LIKE', '좋아요 704', '사용자가 포트폴리오를 좋아했습니다.', '/app/14/item/704', TRUE, '2026-06-05 11:00:00'),



(705, 15, 'BOOKMARK', '보관됨 705', '포트폴리오가 저장되었습니다.', '/app/15/item/705', FALSE, NULL),



(706, 16, 'COMMENT', '회의 706', '새 코멘트가 도착했습니다.', '/app/16/item/706', FALSE, NULL),



(707, 17, 'AI', 'AI 707', '아이 검수가 완료되었습니다.', '/app/17/item/707', FALSE, NULL),



(708, 18, 'SYSTEM', '시스템 708', '시스템 상태가 업데이트되었습니다.', '/app/18/item/708', TRUE, '2026-06-09 11:00:00'),



(709, 19, 'MESSAGE', '새 메시지 709', '새 메시지가 도착했습니다.', '/app/19/item/709', FALSE, NULL),



(710, 20, 'LIKE', '좋아요 710', '사용자가 포트폴리오를 좋아했습니다.', '/app/20/item/710', FALSE, NULL),



(711, 21, 'BOOKMARK', '보관됨 711', '포트폴리오가 저장되었습니다.', '/app/21/item/711', FALSE, NULL),



(712, 22, 'COMMENT', '회의 712', '새 코멘트가 도착했습니다.', '/app/22/item/712', TRUE, '2026-06-13 11:00:00'),



(713, 23, 'AI', 'AI 713', '아이 검수가 완료되었습니다.', '/app/23/item/713', FALSE, NULL),



(714, 24, 'SYSTEM', '시스템 714', '시스템 상태가 업데이트되었습니다.', '/app/24/item/714', FALSE, NULL),



(715, 25, 'MESSAGE', '새 메시지 715', '새 메시지가 도착했습니다.', '/app/25/item/715', FALSE, NULL),



(716, 26, 'LIKE', '좋아요 716', '사용자가 포트폴리오를 좋아했습니다.', '/app/26/item/716', TRUE, '2026-06-17 11:00:00'),



(717, 27, 'BOOKMARK', '보관됨 717', '포트폴리오가 저장되었습니다.', '/app/27/item/717', FALSE, NULL),



(718, 28, 'COMMENT', '회의 718', '새 코멘트가 도착했습니다.', '/app/28/item/718', FALSE, NULL),



(719, 29, 'AI', 'AI 719', '아이 검수가 완료되었습니다.', '/app/29/item/719', FALSE, NULL),



(720, 30, 'SYSTEM', '시스템 720', '시스템 상태가 업데이트되었습니다.', '/app/30/item/720', TRUE, '2026-06-21 11:00:00'),



(721, 1, 'MESSAGE', '새 메시지 721', '새 메시지가 도착했습니다.', '/app/1/item/721', FALSE, NULL),



(722, 2, 'LIKE', '좋아요 722', '사용자가 포트폴리오를 좋아했습니다.', '/app/2/item/722', FALSE, NULL),



(723, 3, 'BOOKMARK', '보관됨 723', '포트폴리오가 저장되었습니다.', '/app/3/item/723', FALSE, NULL),



(724, 4, 'COMMENT', '회의 724', '새 코멘트가 도착했습니다.', '/app/4/item/724', TRUE, '2026-06-25 11:00:00'),



(725, 5, 'AI', 'AI 725', '아이 검수가 완료되었습니다.', '/app/5/item/725', FALSE, NULL),



(726, 6, 'SYSTEM', '시스템 726', '시스템 상태가 업데이트되었습니다.', '/app/6/item/726', FALSE, NULL),



(727, 7, 'MESSAGE', '새 메시지 727', '새 메시지가 도착했습니다.', '/app/7/item/727', FALSE, NULL),



(728, 8, 'LIKE', '좋아요 728', '사용자가 포트폴리오를 좋아했습니다.', '/app/8/item/728', TRUE, '2026-06-01 11:00:00'),



(729, 9, 'BOOKMARK', '보관됨 729', '포트폴리오가 저장되었습니다.', '/app/9/item/729', FALSE, NULL),



(730, 10, 'COMMENT', '회의 730', '새 코멘트가 도착했습니다.', '/app/10/item/730', FALSE, NULL),



(731, 11, 'AI', 'AI 731', '아이 검수가 완료되었습니다.', '/app/11/item/731', FALSE, NULL),



(732, 12, 'SYSTEM', '시스템 732', '시스템 상태가 업데이트되었습니다.', '/app/12/item/732', TRUE, '2026-06-05 11:00:00'),



(733, 13, 'MESSAGE', '새 메시지 733', '새 메시지가 도착했습니다.', '/app/13/item/733', FALSE, NULL),



(734, 14, 'LIKE', '좋아요 734', '사용자가 포트폴리오를 좋아했습니다.', '/app/14/item/734', FALSE, NULL),



(735, 15, 'BOOKMARK', '보관됨 735', '포트폴리오가 저장되었습니다.', '/app/15/item/735', FALSE, NULL),



(736, 16, 'COMMENT', '회의 736', '새 코멘트가 도착했습니다.', '/app/16/item/736', TRUE, '2026-06-09 11:00:00'),



(737, 17, 'AI', 'AI 737', '아이 검수가 완료되었습니다.', '/app/17/item/737', FALSE, NULL),



(738, 18, 'SYSTEM', '시스템 738', '시스템 상태가 업데이트되었습니다.', '/app/18/item/738', FALSE, NULL),



(739, 19, 'MESSAGE', '새 메시지 739', '새 메시지가 도착했습니다.', '/app/19/item/739', FALSE, NULL),



(740, 20, 'LIKE', '좋아요 740', '사용자가 포트폴리오를 좋아했습니다.', '/app/20/item/740', TRUE, '2026-06-13 11:00:00'),



(741, 21, 'BOOKMARK', '보관됨 741', '포트폴리오가 저장되었습니다.', '/app/21/item/741', FALSE, NULL),



(742, 22, 'COMMENT', '회의 742', '새 코멘트가 도착했습니다.', '/app/22/item/742', FALSE, NULL),



(743, 23, 'AI', 'AI 743', '아이 검수가 완료되었습니다.', '/app/23/item/743', FALSE, NULL),



(744, 24, 'SYSTEM', '시스템 744', '시스템 상태가 업데이트되었습니다.', '/app/24/item/744', TRUE, '2026-06-17 11:00:00'),



(745, 25, 'MESSAGE', '새 메시지 745', '새 메시지가 도착했습니다.', '/app/25/item/745', FALSE, NULL),



(746, 26, 'LIKE', '좋아요 746', '사용자가 포트폴리오를 좋아했습니다.', '/app/26/item/746', FALSE, NULL),



(747, 27, 'BOOKMARK', '보관됨 747', '포트폴리오가 저장되었습니다.', '/app/27/item/747', FALSE, NULL),



(748, 28, 'COMMENT', '회의 748', '새 코멘트가 도착했습니다.', '/app/28/item/748', TRUE, '2026-06-21 11:00:00'),



(749, 29, 'AI', 'AI 749', '아이 검수가 완료되었습니다.', '/app/29/item/749', FALSE, NULL),



(750, 30, 'SYSTEM', '시스템 750', '시스템 상태가 업데이트되었습니다.', '/app/30/item/750', FALSE, NULL),



(751, 1, 'MESSAGE', '새 메시지 751', '새 메시지가 도착했습니다.', '/app/1/item/751', FALSE, NULL),



(752, 2, 'LIKE', '좋아요 752', '사용자가 포트폴리오를 좋아했습니다.', '/app/2/item/752', TRUE, '2026-06-25 11:00:00'),



(753, 3, 'BOOKMARK', '보관됨 753', '포트폴리오가 저장되었습니다.', '/app/3/item/753', FALSE, NULL),



(754, 4, 'COMMENT', '회의 754', '새 코멘트가 도착했습니다.', '/app/4/item/754', FALSE, NULL),



(755, 5, 'AI', 'AI 755', '아이 검수가 완료되었습니다.', '/app/5/item/755', FALSE, NULL),



(756, 6, 'SYSTEM', '시스템 756', '시스템 상태가 업데이트되었습니다.', '/app/6/item/756', TRUE, '2026-06-01 11:00:00'),



(757, 7, 'MESSAGE', '새 메시지 757', '새 메시지가 도착했습니다.', '/app/7/item/757', FALSE, NULL),



(758, 8, 'LIKE', '좋아요 758', '사용자가 포트폴리오를 좋아했습니다.', '/app/8/item/758', FALSE, NULL),



(759, 9, 'BOOKMARK', '보관됨 759', '포트폴리오가 저장되었습니다.', '/app/9/item/759', FALSE, NULL),



(760, 10, 'COMMENT', '회의 760', '새 코멘트가 도착했습니다.', '/app/10/item/760', TRUE, '2026-06-05 11:00:00'),



(761, 11, 'AI', 'AI 761', '아이 검수가 완료되었습니다.', '/app/11/item/761', FALSE, NULL),



(762, 12, 'SYSTEM', '시스템 762', '시스템 상태가 업데이트되었습니다.', '/app/12/item/762', FALSE, NULL),



(763, 13, 'MESSAGE', '새 메시지 763', '새 메시지가 도착했습니다.', '/app/13/item/763', FALSE, NULL),



(764, 14, 'LIKE', '좋아요 764', '사용자가 포트폴리오를 좋아했습니다.', '/app/14/item/764', TRUE, '2026-06-09 11:00:00'),



(765, 15, 'BOOKMARK', '보관됨 765', '포트폴리오가 저장되었습니다.', '/app/15/item/765', FALSE, NULL),



(766, 16, 'COMMENT', '회의 766', '새 코멘트가 도착했습니다.', '/app/16/item/766', FALSE, NULL),



(767, 17, 'AI', 'AI 767', '아이 검수가 완료되었습니다.', '/app/17/item/767', FALSE, NULL),



(768, 18, 'SYSTEM', '시스템 768', '시스템 상태가 업데이트되었습니다.', '/app/18/item/768', TRUE, '2026-06-13 11:00:00'),



(769, 19, 'MESSAGE', '새 메시지 769', '새 메시지가 도착했습니다.', '/app/19/item/769', FALSE, NULL),



(770, 20, 'LIKE', '좋아요 770', '사용자가 포트폴리오를 좋아했습니다.', '/app/20/item/770', FALSE, NULL),



(771, 21, 'BOOKMARK', '보관됨 771', '포트폴리오가 저장되었습니다.', '/app/21/item/771', FALSE, NULL),



(772, 22, 'COMMENT', '회의 772', '새 코멘트가 도착했습니다.', '/app/22/item/772', TRUE, '2026-06-17 11:00:00'),



(773, 23, 'AI', 'AI 773', '아이 검수가 완료되었습니다.', '/app/23/item/773', FALSE, NULL),



(774, 24, 'SYSTEM', '시스템 774', '시스템 상태가 업데이트되었습니다.', '/app/24/item/774', FALSE, NULL),



(775, 25, 'MESSAGE', '새 메시지 775', '새 메시지가 도착했습니다.', '/app/25/item/775', FALSE, NULL),



(776, 26, 'LIKE', '좋아요 776', '사용자가 포트폴리오를 좋아했습니다.', '/app/26/item/776', TRUE, '2026-06-21 11:00:00'),



(777, 27, 'BOOKMARK', '보관됨 777', '포트폴리오가 저장되었습니다.', '/app/27/item/777', FALSE, NULL),



(778, 28, 'COMMENT', '회의 778', '새 코멘트가 도착했습니다.', '/app/28/item/778', FALSE, NULL),



(779, 29, 'AI', 'AI 779', '아이 검수가 완료되었습니다.', '/app/29/item/779', FALSE, NULL),



(780, 30, 'SYSTEM', '시스템 780', '시스템 상태가 업데이트되었습니다.', '/app/30/item/780', TRUE, '2026-06-25 11:00:00'),



(781, 1, 'MESSAGE', '새 메시지 781', '새 메시지가 도착했습니다.', '/app/1/item/781', FALSE, NULL),



(782, 2, 'LIKE', '좋아요 782', '사용자가 포트폴리오를 좋아했습니다.', '/app/2/item/782', FALSE, NULL),



(783, 3, 'BOOKMARK', '보관됨 783', '포트폴리오가 저장되었습니다.', '/app/3/item/783', FALSE, NULL),



(784, 4, 'COMMENT', '회의 784', '새 코멘트가 도착했습니다.', '/app/4/item/784', TRUE, '2026-06-01 11:00:00'),



(785, 5, 'AI', 'AI 785', '아이 검수가 완료되었습니다.', '/app/5/item/785', FALSE, NULL),



(786, 6, 'SYSTEM', '시스템 786', '시스템 상태가 업데이트되었습니다.', '/app/6/item/786', FALSE, NULL),



(787, 7, 'MESSAGE', '새 메시지 787', '새 메시지가 도착했습니다.', '/app/7/item/787', FALSE, NULL),



(788, 8, 'LIKE', '좋아요 788', '사용자가 포트폴리오를 좋아했습니다.', '/app/8/item/788', TRUE, '2026-06-05 11:00:00'),



(789, 9, 'BOOKMARK', '보관됨 789', '포트폴리오가 저장되었습니다.', '/app/9/item/789', FALSE, NULL),



(790, 10, 'COMMENT', '회의 790', '새 코멘트가 도착했습니다.', '/app/10/item/790', FALSE, NULL),



(791, 11, 'AI', 'AI 791', '아이 검수가 완료되었습니다.', '/app/11/item/791', FALSE, NULL),



(792, 12, 'SYSTEM', '시스템 792', '시스템 상태가 업데이트되었습니다.', '/app/12/item/792', TRUE, '2026-06-09 11:00:00'),



(793, 13, 'MESSAGE', '새 메시지 793', '새 메시지가 도착했습니다.', '/app/13/item/793', FALSE, NULL),



(794, 14, 'LIKE', '좋아요 794', '사용자가 포트폴리오를 좋아했습니다.', '/app/14/item/794', FALSE, NULL),



(795, 15, 'BOOKMARK', '보관됨 795', '포트폴리오가 저장되었습니다.', '/app/15/item/795', FALSE, NULL),



(796, 16, 'COMMENT', '회의 796', '새 코멘트가 도착했습니다.', '/app/16/item/796', TRUE, '2026-06-13 11:00:00'),



(797, 17, 'AI', 'AI 797', '아이 검수가 완료되었습니다.', '/app/17/item/797', FALSE, NULL),



(798, 18, 'SYSTEM', '시스템 798', '시스템 상태가 업데이트되었습니다.', '/app/18/item/798', FALSE, NULL),



(799, 19, 'MESSAGE', '새 메시지 799', '새 메시지가 도착했습니다.', '/app/19/item/799', FALSE, NULL),



(800, 20, 'LIKE', '좋아요 800', '사용자가 포트폴리오를 좋아했습니다.', '/app/20/item/800', TRUE, '2026-06-17 11:00:00');



INSERT INTO notifications (id, user_id, type, title, content, link_url, is_read, read_at) VALUES



(801, 21, 'BOOKMARK', '보관됨 801', '포트폴리오가 저장되었습니다.', '/app/21/item/801', FALSE, NULL),



(802, 22, 'COMMENT', '회의 802', '새 코멘트가 도착했습니다.', '/app/22/item/802', FALSE, NULL),



(803, 23, 'AI', 'AI 803', '아이 검수가 완료되었습니다.', '/app/23/item/803', FALSE, NULL),



(804, 24, 'SYSTEM', '시스템 804', '시스템 상태가 업데이트되었습니다.', '/app/24/item/804', TRUE, '2026-06-21 11:00:00'),



(805, 25, 'MESSAGE', '새 메시지 805', '새 메시지가 도착했습니다.', '/app/25/item/805', FALSE, NULL),



(806, 26, 'LIKE', '좋아요 806', '사용자가 포트폴리오를 좋아했습니다.', '/app/26/item/806', FALSE, NULL),



(807, 27, 'BOOKMARK', '보관됨 807', '포트폴리오가 저장되었습니다.', '/app/27/item/807', FALSE, NULL),



(808, 28, 'COMMENT', '회의 808', '새 코멘트가 도착했습니다.', '/app/28/item/808', TRUE, '2026-06-25 11:00:00'),



(809, 29, 'AI', 'AI 809', '아이 검수가 완료되었습니다.', '/app/29/item/809', FALSE, NULL),



(810, 30, 'SYSTEM', '시스템 810', '시스템 상태가 업데이트되었습니다.', '/app/30/item/810', FALSE, NULL),



(811, 1, 'MESSAGE', '새 메시지 811', '새 메시지가 도착했습니다.', '/app/1/item/811', FALSE, NULL),



(812, 2, 'LIKE', '좋아요 812', '사용자가 포트폴리오를 좋아했습니다.', '/app/2/item/812', TRUE, '2026-06-01 11:00:00'),



(813, 3, 'BOOKMARK', '보관됨 813', '포트폴리오가 저장되었습니다.', '/app/3/item/813', FALSE, NULL),



(814, 4, 'COMMENT', '회의 814', '새 코멘트가 도착했습니다.', '/app/4/item/814', FALSE, NULL),



(815, 5, 'AI', 'AI 815', '아이 검수가 완료되었습니다.', '/app/5/item/815', FALSE, NULL),



(816, 6, 'SYSTEM', '시스템 816', '시스템 상태가 업데이트되었습니다.', '/app/6/item/816', TRUE, '2026-06-05 11:00:00'),



(817, 7, 'MESSAGE', '새 메시지 817', '새 메시지가 도착했습니다.', '/app/7/item/817', FALSE, NULL),



(818, 8, 'LIKE', '좋아요 818', '사용자가 포트폴리오를 좋아했습니다.', '/app/8/item/818', FALSE, NULL),



(819, 9, 'BOOKMARK', '보관됨 819', '포트폴리오가 저장되었습니다.', '/app/9/item/819', FALSE, NULL),



(820, 10, 'COMMENT', '회의 820', '새 코멘트가 도착했습니다.', '/app/10/item/820', TRUE, '2026-06-09 11:00:00'),



(821, 11, 'AI', 'AI 821', '아이 검수가 완료되었습니다.', '/app/11/item/821', FALSE, NULL),



(822, 12, 'SYSTEM', '시스템 822', '시스템 상태가 업데이트되었습니다.', '/app/12/item/822', FALSE, NULL),



(823, 13, 'MESSAGE', '새 메시지 823', '새 메시지가 도착했습니다.', '/app/13/item/823', FALSE, NULL),



(824, 14, 'LIKE', '좋아요 824', '사용자가 포트폴리오를 좋아했습니다.', '/app/14/item/824', TRUE, '2026-06-13 11:00:00'),



(825, 15, 'BOOKMARK', '보관됨 825', '포트폴리오가 저장되었습니다.', '/app/15/item/825', FALSE, NULL),



(826, 16, 'COMMENT', '회의 826', '새 코멘트가 도착했습니다.', '/app/16/item/826', FALSE, NULL),



(827, 17, 'AI', 'AI 827', '아이 검수가 완료되었습니다.', '/app/17/item/827', FALSE, NULL),



(828, 18, 'SYSTEM', '시스템 828', '시스템 상태가 업데이트되었습니다.', '/app/18/item/828', TRUE, '2026-06-17 11:00:00'),



(829, 19, 'MESSAGE', '새 메시지 829', '새 메시지가 도착했습니다.', '/app/19/item/829', FALSE, NULL),



(830, 20, 'LIKE', '좋아요 830', '사용자가 포트폴리오를 좋아했습니다.', '/app/20/item/830', FALSE, NULL),



(831, 21, 'BOOKMARK', '보관됨 831', '포트폴리오가 저장되었습니다.', '/app/21/item/831', FALSE, NULL),



(832, 22, 'COMMENT', '회의 832', '새 코멘트가 도착했습니다.', '/app/22/item/832', TRUE, '2026-06-21 11:00:00'),



(833, 23, 'AI', 'AI 833', '아이 검수가 완료되었습니다.', '/app/23/item/833', FALSE, NULL),



(834, 24, 'SYSTEM', '시스템 834', '시스템 상태가 업데이트되었습니다.', '/app/24/item/834', FALSE, NULL),



(835, 25, 'MESSAGE', '새 메시지 835', '새 메시지가 도착했습니다.', '/app/25/item/835', FALSE, NULL),



(836, 26, 'LIKE', '좋아요 836', '사용자가 포트폴리오를 좋아했습니다.', '/app/26/item/836', TRUE, '2026-06-25 11:00:00'),



(837, 27, 'BOOKMARK', '보관됨 837', '포트폴리오가 저장되었습니다.', '/app/27/item/837', FALSE, NULL),



(838, 28, 'COMMENT', '회의 838', '새 코멘트가 도착했습니다.', '/app/28/item/838', FALSE, NULL),



(839, 29, 'AI', 'AI 839', '아이 검수가 완료되었습니다.', '/app/29/item/839', FALSE, NULL),



(840, 30, 'SYSTEM', '시스템 840', '시스템 상태가 업데이트되었습니다.', '/app/30/item/840', TRUE, '2026-06-01 11:00:00'),



(841, 1, 'MESSAGE', '새 메시지 841', '새 메시지가 도착했습니다.', '/app/1/item/841', FALSE, NULL),



(842, 2, 'LIKE', '좋아요 842', '사용자가 포트폴리오를 좋아했습니다.', '/app/2/item/842', FALSE, NULL),



(843, 3, 'BOOKMARK', '보관됨 843', '포트폴리오가 저장되었습니다.', '/app/3/item/843', FALSE, NULL),



(844, 4, 'COMMENT', '회의 844', '새 코멘트가 도착했습니다.', '/app/4/item/844', TRUE, '2026-06-05 11:00:00'),



(845, 5, 'AI', 'AI 845', '아이 검수가 완료되었습니다.', '/app/5/item/845', FALSE, NULL),



(846, 6, 'SYSTEM', '시스템 846', '시스템 상태가 업데이트되었습니다.', '/app/6/item/846', FALSE, NULL),



(847, 7, 'MESSAGE', '새 메시지 847', '새 메시지가 도착했습니다.', '/app/7/item/847', FALSE, NULL),



(848, 8, 'LIKE', '좋아요 848', '사용자가 포트폴리오를 좋아했습니다.', '/app/8/item/848', TRUE, '2026-06-09 11:00:00'),



(849, 9, 'BOOKMARK', '보관됨 849', '포트폴리오가 저장되었습니다.', '/app/9/item/849', FALSE, NULL),



(850, 10, 'COMMENT', '회의 850', '새 코멘트가 도착했습니다.', '/app/10/item/850', FALSE, NULL),



(851, 11, 'AI', 'AI 851', '아이 검수가 완료되었습니다.', '/app/11/item/851', FALSE, NULL),



(852, 12, 'SYSTEM', '시스템 852', '시스템 상태가 업데이트되었습니다.', '/app/12/item/852', TRUE, '2026-06-13 11:00:00'),



(853, 13, 'MESSAGE', '새 메시지 853', '새 메시지가 도착했습니다.', '/app/13/item/853', FALSE, NULL),



(854, 14, 'LIKE', '좋아요 854', '사용자가 포트폴리오를 좋아했습니다.', '/app/14/item/854', FALSE, NULL),



(855, 15, 'BOOKMARK', '보관됨 855', '포트폴리오가 저장되었습니다.', '/app/15/item/855', FALSE, NULL),



(856, 16, 'COMMENT', '회의 856', '새 코멘트가 도착했습니다.', '/app/16/item/856', TRUE, '2026-06-17 11:00:00'),



(857, 17, 'AI', 'AI 857', '아이 검수가 완료되었습니다.', '/app/17/item/857', FALSE, NULL),



(858, 18, 'SYSTEM', '시스템 858', '시스템 상태가 업데이트되었습니다.', '/app/18/item/858', FALSE, NULL),



(859, 19, 'MESSAGE', '새 메시지 859', '새 메시지가 도착했습니다.', '/app/19/item/859', FALSE, NULL),



(860, 20, 'LIKE', '좋아요 860', '사용자가 포트폴리오를 좋아했습니다.', '/app/20/item/860', TRUE, '2026-06-21 11:00:00'),



(861, 21, 'BOOKMARK', '보관됨 861', '포트폴리오가 저장되었습니다.', '/app/21/item/861', FALSE, NULL),



(862, 22, 'COMMENT', '회의 862', '새 코멘트가 도착했습니다.', '/app/22/item/862', FALSE, NULL),



(863, 23, 'AI', 'AI 863', '아이 검수가 완료되었습니다.', '/app/23/item/863', FALSE, NULL),



(864, 24, 'SYSTEM', '시스템 864', '시스템 상태가 업데이트되었습니다.', '/app/24/item/864', TRUE, '2026-06-25 11:00:00'),



(865, 25, 'MESSAGE', '새 메시지 865', '새 메시지가 도착했습니다.', '/app/25/item/865', FALSE, NULL),



(866, 26, 'LIKE', '좋아요 866', '사용자가 포트폴리오를 좋아했습니다.', '/app/26/item/866', FALSE, NULL),



(867, 27, 'BOOKMARK', '보관됨 867', '포트폴리오가 저장되었습니다.', '/app/27/item/867', FALSE, NULL),



(868, 28, 'COMMENT', '회의 868', '새 코멘트가 도착했습니다.', '/app/28/item/868', TRUE, '2026-06-01 11:00:00'),



(869, 29, 'AI', 'AI 869', '아이 검수가 완료되었습니다.', '/app/29/item/869', FALSE, NULL),



(870, 30, 'SYSTEM', '시스템 870', '시스템 상태가 업데이트되었습니다.', '/app/30/item/870', FALSE, NULL),



(871, 1, 'MESSAGE', '새 메시지 871', '새 메시지가 도착했습니다.', '/app/1/item/871', FALSE, NULL),



(872, 2, 'LIKE', '좋아요 872', '사용자가 포트폴리오를 좋아했습니다.', '/app/2/item/872', TRUE, '2026-06-05 11:00:00'),



(873, 3, 'BOOKMARK', '보관됨 873', '포트폴리오가 저장되었습니다.', '/app/3/item/873', FALSE, NULL),



(874, 4, 'COMMENT', '회의 874', '새 코멘트가 도착했습니다.', '/app/4/item/874', FALSE, NULL),



(875, 5, 'AI', 'AI 875', '아이 검수가 완료되었습니다.', '/app/5/item/875', FALSE, NULL),



(876, 6, 'SYSTEM', '시스템 876', '시스템 상태가 업데이트되었습니다.', '/app/6/item/876', TRUE, '2026-06-09 11:00:00'),



(877, 7, 'MESSAGE', '새 메시지 877', '새 메시지가 도착했습니다.', '/app/7/item/877', FALSE, NULL),



(878, 8, 'LIKE', '좋아요 878', '사용자가 포트폴리오를 좋아했습니다.', '/app/8/item/878', FALSE, NULL),



(879, 9, 'BOOKMARK', '보관됨 879', '포트폴리오가 저장되었습니다.', '/app/9/item/879', FALSE, NULL),



(880, 10, 'COMMENT', '회의 880', '새 코멘트가 도착했습니다.', '/app/10/item/880', TRUE, '2026-06-13 11:00:00'),



(881, 11, 'AI', 'AI 881', '아이 검수가 완료되었습니다.', '/app/11/item/881', FALSE, NULL),



(882, 12, 'SYSTEM', '시스템 882', '시스템 상태가 업데이트되었습니다.', '/app/12/item/882', FALSE, NULL),



(883, 13, 'MESSAGE', '새 메시지 883', '새 메시지가 도착했습니다.', '/app/13/item/883', FALSE, NULL),



(884, 14, 'LIKE', '좋아요 884', '사용자가 포트폴리오를 좋아했습니다.', '/app/14/item/884', TRUE, '2026-06-17 11:00:00'),



(885, 15, 'BOOKMARK', '보관됨 885', '포트폴리오가 저장되었습니다.', '/app/15/item/885', FALSE, NULL),



(886, 16, 'COMMENT', '회의 886', '새 코멘트가 도착했습니다.', '/app/16/item/886', FALSE, NULL),



(887, 17, 'AI', 'AI 887', '아이 검수가 완료되었습니다.', '/app/17/item/887', FALSE, NULL),



(888, 18, 'SYSTEM', '시스템 888', '시스템 상태가 업데이트되었습니다.', '/app/18/item/888', TRUE, '2026-06-21 11:00:00'),



(889, 19, 'MESSAGE', '새 메시지 889', '새 메시지가 도착했습니다.', '/app/19/item/889', FALSE, NULL),



(890, 20, 'LIKE', '좋아요 890', '사용자가 포트폴리오를 좋아했습니다.', '/app/20/item/890', FALSE, NULL),



(891, 21, 'BOOKMARK', '보관됨 891', '포트폴리오가 저장되었습니다.', '/app/21/item/891', FALSE, NULL),



(892, 22, 'COMMENT', '회의 892', '새 코멘트가 도착했습니다.', '/app/22/item/892', TRUE, '2026-06-25 11:00:00'),



(893, 23, 'AI', 'AI 893', '아이 검수가 완료되었습니다.', '/app/23/item/893', FALSE, NULL),



(894, 24, 'SYSTEM', '시스템 894', '시스템 상태가 업데이트되었습니다.', '/app/24/item/894', FALSE, NULL),



(895, 25, 'MESSAGE', '새 메시지 895', '새 메시지가 도착했습니다.', '/app/25/item/895', FALSE, NULL),



(896, 26, 'LIKE', '좋아요 896', '사용자가 포트폴리오를 좋아했습니다.', '/app/26/item/896', TRUE, '2026-06-01 11:00:00'),



(897, 27, 'BOOKMARK', '보관됨 897', '포트폴리오가 저장되었습니다.', '/app/27/item/897', FALSE, NULL),



(898, 28, 'COMMENT', '회의 898', '새 코멘트가 도착했습니다.', '/app/28/item/898', FALSE, NULL),



(899, 29, 'AI', 'AI 899', '아이 검수가 완료되었습니다.', '/app/29/item/899', FALSE, NULL),



(900, 30, 'SYSTEM', '시스템 900', '시스템 상태가 업데이트되었습니다.', '/app/30/item/900', TRUE, '2026-06-05 11:00:00'),



(901, 1, 'MESSAGE', '새 메시지 901', '새 메시지가 도착했습니다.', '/app/1/item/901', FALSE, NULL),



(902, 2, 'LIKE', '좋아요 902', '사용자가 포트폴리오를 좋아했습니다.', '/app/2/item/902', FALSE, NULL),



(903, 3, 'BOOKMARK', '보관됨 903', '포트폴리오가 저장되었습니다.', '/app/3/item/903', FALSE, NULL),



(904, 4, 'COMMENT', '회의 904', '새 코멘트가 도착했습니다.', '/app/4/item/904', TRUE, '2026-06-09 11:00:00'),



(905, 5, 'AI', 'AI 905', '아이 검수가 완료되었습니다.', '/app/5/item/905', FALSE, NULL),



(906, 6, 'SYSTEM', '시스템 906', '시스템 상태가 업데이트되었습니다.', '/app/6/item/906', FALSE, NULL),



(907, 7, 'MESSAGE', '새 메시지 907', '새 메시지가 도착했습니다.', '/app/7/item/907', FALSE, NULL),



(908, 8, 'LIKE', '좋아요 908', '사용자가 포트폴리오를 좋아했습니다.', '/app/8/item/908', TRUE, '2026-06-13 11:00:00'),



(909, 9, 'BOOKMARK', '보관됨 909', '포트폴리오가 저장되었습니다.', '/app/9/item/909', FALSE, NULL),



(910, 10, 'COMMENT', '회의 910', '새 코멘트가 도착했습니다.', '/app/10/item/910', FALSE, NULL),



(911, 11, 'AI', 'AI 911', '아이 검수가 완료되었습니다.', '/app/11/item/911', FALSE, NULL),



(912, 12, 'SYSTEM', '시스템 912', '시스템 상태가 업데이트되었습니다.', '/app/12/item/912', TRUE, '2026-06-17 11:00:00'),



(913, 13, 'MESSAGE', '새 메시지 913', '새 메시지가 도착했습니다.', '/app/13/item/913', FALSE, NULL),



(914, 14, 'LIKE', '좋아요 914', '사용자가 포트폴리오를 좋아했습니다.', '/app/14/item/914', FALSE, NULL),



(915, 15, 'BOOKMARK', '보관됨 915', '포트폴리오가 저장되었습니다.', '/app/15/item/915', FALSE, NULL),



(916, 16, 'COMMENT', '회의 916', '새 코멘트가 도착했습니다.', '/app/16/item/916', TRUE, '2026-06-21 11:00:00'),



(917, 17, 'AI', 'AI 917', '아이 검수가 완료되었습니다.', '/app/17/item/917', FALSE, NULL),



(918, 18, 'SYSTEM', '시스템 918', '시스템 상태가 업데이트되었습니다.', '/app/18/item/918', FALSE, NULL),



(919, 19, 'MESSAGE', '새 메시지 919', '새 메시지가 도착했습니다.', '/app/19/item/919', FALSE, NULL),



(920, 20, 'LIKE', '좋아요 920', '사용자가 포트폴리오를 좋아했습니다.', '/app/20/item/920', TRUE, '2026-06-25 11:00:00'),



(921, 21, 'BOOKMARK', '보관됨 921', '포트폴리오가 저장되었습니다.', '/app/21/item/921', FALSE, NULL),



(922, 22, 'COMMENT', '회의 922', '새 코멘트가 도착했습니다.', '/app/22/item/922', FALSE, NULL),



(923, 23, 'AI', 'AI 923', '아이 검수가 완료되었습니다.', '/app/23/item/923', FALSE, NULL),



(924, 24, 'SYSTEM', '시스템 924', '시스템 상태가 업데이트되었습니다.', '/app/24/item/924', TRUE, '2026-06-01 11:00:00'),



(925, 25, 'MESSAGE', '새 메시지 925', '새 메시지가 도착했습니다.', '/app/25/item/925', FALSE, NULL),



(926, 26, 'LIKE', '좋아요 926', '사용자가 포트폴리오를 좋아했습니다.', '/app/26/item/926', FALSE, NULL),



(927, 27, 'BOOKMARK', '보관됨 927', '포트폴리오가 저장되었습니다.', '/app/27/item/927', FALSE, NULL),



(928, 28, 'COMMENT', '회의 928', '새 코멘트가 도착했습니다.', '/app/28/item/928', TRUE, '2026-06-05 11:00:00'),



(929, 29, 'AI', 'AI 929', '아이 검수가 완료되었습니다.', '/app/29/item/929', FALSE, NULL),



(930, 30, 'SYSTEM', '시스템 930', '시스템 상태가 업데이트되었습니다.', '/app/30/item/930', FALSE, NULL),



(931, 1, 'MESSAGE', '새 메시지 931', '새 메시지가 도착했습니다.', '/app/1/item/931', FALSE, NULL),



(932, 2, 'LIKE', '좋아요 932', '사용자가 포트폴리오를 좋아했습니다.', '/app/2/item/932', TRUE, '2026-06-09 11:00:00'),



(933, 3, 'BOOKMARK', '보관됨 933', '포트폴리오가 저장되었습니다.', '/app/3/item/933', FALSE, NULL),



(934, 4, 'COMMENT', '회의 934', '새 코멘트가 도착했습니다.', '/app/4/item/934', FALSE, NULL),



(935, 5, 'AI', 'AI 935', '아이 검수가 완료되었습니다.', '/app/5/item/935', FALSE, NULL),



(936, 6, 'SYSTEM', '시스템 936', '시스템 상태가 업데이트되었습니다.', '/app/6/item/936', TRUE, '2026-06-13 11:00:00'),



(937, 7, 'MESSAGE', '새 메시지 937', '새 메시지가 도착했습니다.', '/app/7/item/937', FALSE, NULL),



(938, 8, 'LIKE', '좋아요 938', '사용자가 포트폴리오를 좋아했습니다.', '/app/8/item/938', FALSE, NULL),



(939, 9, 'BOOKMARK', '보관됨 939', '포트폴리오가 저장되었습니다.', '/app/9/item/939', FALSE, NULL),



(940, 10, 'COMMENT', '회의 940', '새 코멘트가 도착했습니다.', '/app/10/item/940', TRUE, '2026-06-17 11:00:00'),



(941, 11, 'AI', 'AI 941', '아이 검수가 완료되었습니다.', '/app/11/item/941', FALSE, NULL),



(942, 12, 'SYSTEM', '시스템 942', '시스템 상태가 업데이트되었습니다.', '/app/12/item/942', FALSE, NULL),



(943, 13, 'MESSAGE', '새 메시지 943', '새 메시지가 도착했습니다.', '/app/13/item/943', FALSE, NULL),



(944, 14, 'LIKE', '좋아요 944', '사용자가 포트폴리오를 좋아했습니다.', '/app/14/item/944', TRUE, '2026-06-21 11:00:00'),



(945, 15, 'BOOKMARK', '보관됨 945', '포트폴리오가 저장되었습니다.', '/app/15/item/945', FALSE, NULL),



(946, 16, 'COMMENT', '회의 946', '새 코멘트가 도착했습니다.', '/app/16/item/946', FALSE, NULL),



(947, 17, 'AI', 'AI 947', '아이 검수가 완료되었습니다.', '/app/17/item/947', FALSE, NULL),



(948, 18, 'SYSTEM', '시스템 948', '시스템 상태가 업데이트되었습니다.', '/app/18/item/948', TRUE, '2026-06-25 11:00:00'),



(949, 19, 'MESSAGE', '새 메시지 949', '새 메시지가 도착했습니다.', '/app/19/item/949', FALSE, NULL),



(950, 20, 'LIKE', '좋아요 950', '사용자가 포트폴리오를 좋아했습니다.', '/app/20/item/950', FALSE, NULL),



(951, 21, 'BOOKMARK', '보관됨 951', '포트폴리오가 저장되었습니다.', '/app/21/item/951', FALSE, NULL),



(952, 22, 'COMMENT', '회의 952', '새 코멘트가 도착했습니다.', '/app/22/item/952', TRUE, '2026-06-01 11:00:00'),



(953, 23, 'AI', 'AI 953', '아이 검수가 완료되었습니다.', '/app/23/item/953', FALSE, NULL),



(954, 24, 'SYSTEM', '시스템 954', '시스템 상태가 업데이트되었습니다.', '/app/24/item/954', FALSE, NULL),



(955, 25, 'MESSAGE', '새 메시지 955', '새 메시지가 도착했습니다.', '/app/25/item/955', FALSE, NULL),



(956, 26, 'LIKE', '좋아요 956', '사용자가 포트폴리오를 좋아했습니다.', '/app/26/item/956', TRUE, '2026-06-05 11:00:00'),



(957, 27, 'BOOKMARK', '보관됨 957', '포트폴리오가 저장되었습니다.', '/app/27/item/957', FALSE, NULL),



(958, 28, 'COMMENT', '회의 958', '새 코멘트가 도착했습니다.', '/app/28/item/958', FALSE, NULL),



(959, 29, 'AI', 'AI 959', '아이 검수가 완료되었습니다.', '/app/29/item/959', FALSE, NULL),



(960, 30, 'SYSTEM', '시스템 960', '시스템 상태가 업데이트되었습니다.', '/app/30/item/960', TRUE, '2026-06-09 11:00:00'),



(961, 1, 'MESSAGE', '새 메시지 961', '새 메시지가 도착했습니다.', '/app/1/item/961', FALSE, NULL),



(962, 2, 'LIKE', '좋아요 962', '사용자가 포트폴리오를 좋아했습니다.', '/app/2/item/962', FALSE, NULL),



(963, 3, 'BOOKMARK', '보관됨 963', '포트폴리오가 저장되었습니다.', '/app/3/item/963', FALSE, NULL),



(964, 4, 'COMMENT', '회의 964', '새 코멘트가 도착했습니다.', '/app/4/item/964', TRUE, '2026-06-13 11:00:00'),



(965, 5, 'AI', 'AI 965', '아이 검수가 완료되었습니다.', '/app/5/item/965', FALSE, NULL),



(966, 6, 'SYSTEM', '시스템 966', '시스템 상태가 업데이트되었습니다.', '/app/6/item/966', FALSE, NULL),



(967, 7, 'MESSAGE', '새 메시지 967', '새 메시지가 도착했습니다.', '/app/7/item/967', FALSE, NULL),



(968, 8, 'LIKE', '좋아요 968', '사용자가 포트폴리오를 좋아했습니다.', '/app/8/item/968', TRUE, '2026-06-17 11:00:00'),



(969, 9, 'BOOKMARK', '보관됨 969', '포트폴리오가 저장되었습니다.', '/app/9/item/969', FALSE, NULL),



(970, 10, 'COMMENT', '회의 970', '새 코멘트가 도착했습니다.', '/app/10/item/970', FALSE, NULL),



(971, 11, 'AI', 'AI 971', '아이 검수가 완료되었습니다.', '/app/11/item/971', FALSE, NULL),



(972, 12, 'SYSTEM', '시스템 972', '시스템 상태가 업데이트되었습니다.', '/app/12/item/972', TRUE, '2026-06-21 11:00:00'),



(973, 13, 'MESSAGE', '새 메시지 973', '새 메시지가 도착했습니다.', '/app/13/item/973', FALSE, NULL),



(974, 14, 'LIKE', '좋아요 974', '사용자가 포트폴리오를 좋아했습니다.', '/app/14/item/974', FALSE, NULL),



(975, 15, 'BOOKMARK', '보관됨 975', '포트폴리오가 저장되었습니다.', '/app/15/item/975', FALSE, NULL),



(976, 16, 'COMMENT', '회의 976', '새 코멘트가 도착했습니다.', '/app/16/item/976', TRUE, '2026-06-25 11:00:00'),



(977, 17, 'AI', 'AI 977', '아이 검수가 완료되었습니다.', '/app/17/item/977', FALSE, NULL),



(978, 18, 'SYSTEM', '시스템 978', '시스템 상태가 업데이트되었습니다.', '/app/18/item/978', FALSE, NULL),



(979, 19, 'MESSAGE', '새 메시지 979', '새 메시지가 도착했습니다.', '/app/19/item/979', FALSE, NULL),



(980, 20, 'LIKE', '좋아요 980', '사용자가 포트폴리오를 좋아했습니다.', '/app/20/item/980', TRUE, '2026-06-01 11:00:00'),



(981, 21, 'BOOKMARK', '보관됨 981', '포트폴리오가 저장되었습니다.', '/app/21/item/981', FALSE, NULL),



(982, 22, 'COMMENT', '회의 982', '새 코멘트가 도착했습니다.', '/app/22/item/982', FALSE, NULL),



(983, 23, 'AI', 'AI 983', '아이 검수가 완료되었습니다.', '/app/23/item/983', FALSE, NULL),



(984, 24, 'SYSTEM', '시스템 984', '시스템 상태가 업데이트되었습니다.', '/app/24/item/984', TRUE, '2026-06-05 11:00:00'),



(985, 25, 'MESSAGE', '새 메시지 985', '새 메시지가 도착했습니다.', '/app/25/item/985', FALSE, NULL),



(986, 26, 'LIKE', '좋아요 986', '사용자가 포트폴리오를 좋아했습니다.', '/app/26/item/986', FALSE, NULL),



(987, 27, 'BOOKMARK', '보관됨 987', '포트폴리오가 저장되었습니다.', '/app/27/item/987', FALSE, NULL),



(988, 28, 'COMMENT', '회의 988', '새 코멘트가 도착했습니다.', '/app/28/item/988', TRUE, '2026-06-09 11:00:00'),



(989, 29, 'AI', 'AI 989', '아이 검수가 완료되었습니다.', '/app/29/item/989', FALSE, NULL),



(990, 30, 'SYSTEM', '시스템 990', '시스템 상태가 업데이트되었습니다.', '/app/30/item/990', FALSE, NULL),



(991, 1, 'MESSAGE', '새 메시지 991', '새 메시지가 도착했습니다.', '/app/1/item/991', FALSE, NULL),



(992, 2, 'LIKE', '좋아요 992', '사용자가 포트폴리오를 좋아했습니다.', '/app/2/item/992', TRUE, '2026-06-13 11:00:00'),



(993, 3, 'BOOKMARK', '보관됨 993', '포트폴리오가 저장되었습니다.', '/app/3/item/993', FALSE, NULL),



(994, 4, 'COMMENT', '회의 994', '새 코멘트가 도착했습니다.', '/app/4/item/994', FALSE, NULL),



(995, 5, 'AI', 'AI 995', '아이 검수가 완료되었습니다.', '/app/5/item/995', FALSE, NULL),



(996, 6, 'SYSTEM', '시스템 996', '시스템 상태가 업데이트되었습니다.', '/app/6/item/996', TRUE, '2026-06-17 11:00:00'),



(997, 7, 'MESSAGE', '새 메시지 997', '새 메시지가 도착했습니다.', '/app/7/item/997', FALSE, NULL),



(998, 8, 'LIKE', '좋아요 998', '사용자가 포트폴리오를 좋아했습니다.', '/app/8/item/998', FALSE, NULL),



(999, 9, 'BOOKMARK', '보관됨 999', '포트폴리오가 저장되었습니다.', '/app/9/item/999', FALSE, NULL),



(1000, 10, 'COMMENT', '회의 1000', '새 코멘트가 도착했습니다.', '/app/10/item/1000', TRUE, '2026-06-21 11:00:00');



INSERT INTO realtime_events (id, user_id, event_type, payload, created_at) VALUES



(1, 1, 'notification', '{"eventId": 1, "kind": "MESSAGE", "message": "실시간 이번트 1가 도착했습니다."}'::jsonb, '2026-06-02 11:05:00'),



(2, 2, 'message', '{"eventId": 2, "kind": "LIKE", "message": "실시간 이번트 2가 도착했습니다."}'::jsonb, '2026-06-03 11:05:00'),



(3, 3, 'notification', '{"eventId": 3, "kind": "BOOKMARK", "message": "실시간 이번트 3가 도착했습니다."}'::jsonb, '2026-06-04 11:05:00'),



(4, 4, 'message', '{"eventId": 4, "kind": "COMMENT", "message": "실시간 이번트 4가 도착했습니다."}'::jsonb, '2026-06-05 11:05:00'),



(5, 5, 'notification', '{"eventId": 5, "kind": "AI", "message": "실시간 이번트 5가 도착했습니다."}'::jsonb, '2026-06-06 11:05:00'),



(6, 6, 'message', '{"eventId": 6, "kind": "SYSTEM", "message": "실시간 이번트 6가 도착했습니다."}'::jsonb, '2026-06-07 11:05:00'),



(7, 7, 'notification', '{"eventId": 7, "kind": "MESSAGE", "message": "실시간 이번트 7가 도착했습니다."}'::jsonb, '2026-06-08 11:05:00'),



(8, 8, 'message', '{"eventId": 8, "kind": "LIKE", "message": "실시간 이번트 8가 도착했습니다."}'::jsonb, '2026-06-09 11:05:00'),



(9, 9, 'notification', '{"eventId": 9, "kind": "BOOKMARK", "message": "실시간 이번트 9가 도착했습니다."}'::jsonb, '2026-06-10 11:05:00'),



(10, 10, 'message', '{"eventId": 10, "kind": "COMMENT", "message": "실시간 이번트 10가 도착했습니다."}'::jsonb, '2026-06-11 11:05:00'),



(11, 11, 'notification', '{"eventId": 11, "kind": "AI", "message": "실시간 이번트 11가 도착했습니다."}'::jsonb, '2026-06-12 11:05:00'),



(12, 12, 'message', '{"eventId": 12, "kind": "SYSTEM", "message": "실시간 이번트 12가 도착했습니다."}'::jsonb, '2026-06-13 11:05:00'),



(13, 13, 'notification', '{"eventId": 13, "kind": "MESSAGE", "message": "실시간 이번트 13가 도착했습니다."}'::jsonb, '2026-06-14 11:05:00'),



(14, 14, 'message', '{"eventId": 14, "kind": "LIKE", "message": "실시간 이번트 14가 도착했습니다."}'::jsonb, '2026-06-15 11:05:00'),



(15, 15, 'notification', '{"eventId": 15, "kind": "BOOKMARK", "message": "실시간 이번트 15가 도착했습니다."}'::jsonb, '2026-06-16 11:05:00'),



(16, 16, 'message', '{"eventId": 16, "kind": "COMMENT", "message": "실시간 이번트 16가 도착했습니다."}'::jsonb, '2026-06-17 11:05:00'),



(17, 17, 'notification', '{"eventId": 17, "kind": "AI", "message": "실시간 이번트 17가 도착했습니다."}'::jsonb, '2026-06-18 11:05:00'),



(18, 18, 'message', '{"eventId": 18, "kind": "SYSTEM", "message": "실시간 이번트 18가 도착했습니다."}'::jsonb, '2026-06-19 11:05:00'),



(19, 19, 'notification', '{"eventId": 19, "kind": "MESSAGE", "message": "실시간 이번트 19가 도착했습니다."}'::jsonb, '2026-06-20 11:05:00'),



(20, 20, 'message', '{"eventId": 20, "kind": "LIKE", "message": "실시간 이번트 20가 도착했습니다."}'::jsonb, '2026-06-21 11:05:00'),



(21, 21, 'notification', '{"eventId": 21, "kind": "BOOKMARK", "message": "실시간 이번트 21가 도착했습니다."}'::jsonb, '2026-06-22 11:05:00'),



(22, 22, 'message', '{"eventId": 22, "kind": "COMMENT", "message": "실시간 이번트 22가 도착했습니다."}'::jsonb, '2026-06-23 11:05:00'),



(23, 23, 'notification', '{"eventId": 23, "kind": "AI", "message": "실시간 이번트 23가 도착했습니다."}'::jsonb, '2026-06-24 11:05:00'),



(24, 24, 'message', '{"eventId": 24, "kind": "SYSTEM", "message": "실시간 이번트 24가 도착했습니다."}'::jsonb, '2026-06-25 11:05:00'),



(25, 25, 'notification', '{"eventId": 25, "kind": "MESSAGE", "message": "실시간 이번트 25가 도착했습니다."}'::jsonb, '2026-06-26 11:05:00'),



(26, 26, 'message', '{"eventId": 26, "kind": "LIKE", "message": "실시간 이번트 26가 도착했습니다."}'::jsonb, '2026-06-27 11:05:00'),



(27, 27, 'notification', '{"eventId": 27, "kind": "BOOKMARK", "message": "실시간 이번트 27가 도착했습니다."}'::jsonb, '2026-06-28 11:05:00'),



(28, 28, 'message', '{"eventId": 28, "kind": "COMMENT", "message": "실시간 이번트 28가 도착했습니다."}'::jsonb, '2026-06-01 11:05:00'),



(29, 29, 'notification', '{"eventId": 29, "kind": "AI", "message": "실시간 이번트 29가 도착했습니다."}'::jsonb, '2026-06-02 11:05:00'),



(30, 30, 'message', '{"eventId": 30, "kind": "SYSTEM", "message": "실시간 이번트 30가 도착했습니다."}'::jsonb, '2026-06-03 11:05:00'),



(31, 1, 'notification', '{"eventId": 31, "kind": "MESSAGE", "message": "실시간 이번트 31가 도착했습니다."}'::jsonb, '2026-06-04 11:05:00'),



(32, 2, 'message', '{"eventId": 32, "kind": "LIKE", "message": "실시간 이번트 32가 도착했습니다."}'::jsonb, '2026-06-05 11:05:00'),



(33, 3, 'notification', '{"eventId": 33, "kind": "BOOKMARK", "message": "실시간 이번트 33가 도착했습니다."}'::jsonb, '2026-06-06 11:05:00'),



(34, 4, 'message', '{"eventId": 34, "kind": "COMMENT", "message": "실시간 이번트 34가 도착했습니다."}'::jsonb, '2026-06-07 11:05:00'),



(35, 5, 'notification', '{"eventId": 35, "kind": "AI", "message": "실시간 이번트 35가 도착했습니다."}'::jsonb, '2026-06-08 11:05:00'),



(36, 6, 'message', '{"eventId": 36, "kind": "SYSTEM", "message": "실시간 이번트 36가 도착했습니다."}'::jsonb, '2026-06-09 11:05:00'),



(37, 7, 'notification', '{"eventId": 37, "kind": "MESSAGE", "message": "실시간 이번트 37가 도착했습니다."}'::jsonb, '2026-06-10 11:05:00'),



(38, 8, 'message', '{"eventId": 38, "kind": "LIKE", "message": "실시간 이번트 38가 도착했습니다."}'::jsonb, '2026-06-11 11:05:00'),



(39, 9, 'notification', '{"eventId": 39, "kind": "BOOKMARK", "message": "실시간 이번트 39가 도착했습니다."}'::jsonb, '2026-06-12 11:05:00'),



(40, 10, 'message', '{"eventId": 40, "kind": "COMMENT", "message": "실시간 이번트 40가 도착했습니다."}'::jsonb, '2026-06-13 11:05:00'),



(41, 11, 'notification', '{"eventId": 41, "kind": "AI", "message": "실시간 이번트 41가 도착했습니다."}'::jsonb, '2026-06-14 11:05:00'),



(42, 12, 'message', '{"eventId": 42, "kind": "SYSTEM", "message": "실시간 이번트 42가 도착했습니다."}'::jsonb, '2026-06-15 11:05:00'),



(43, 13, 'notification', '{"eventId": 43, "kind": "MESSAGE", "message": "실시간 이번트 43가 도착했습니다."}'::jsonb, '2026-06-16 11:05:00'),



(44, 14, 'message', '{"eventId": 44, "kind": "LIKE", "message": "실시간 이번트 44가 도착했습니다."}'::jsonb, '2026-06-17 11:05:00'),



(45, 15, 'notification', '{"eventId": 45, "kind": "BOOKMARK", "message": "실시간 이번트 45가 도착했습니다."}'::jsonb, '2026-06-18 11:05:00'),



(46, 16, 'message', '{"eventId": 46, "kind": "COMMENT", "message": "실시간 이번트 46가 도착했습니다."}'::jsonb, '2026-06-19 11:05:00'),



(47, 17, 'notification', '{"eventId": 47, "kind": "AI", "message": "실시간 이번트 47가 도착했습니다."}'::jsonb, '2026-06-20 11:05:00'),



(48, 18, 'message', '{"eventId": 48, "kind": "SYSTEM", "message": "실시간 이번트 48가 도착했습니다."}'::jsonb, '2026-06-21 11:05:00'),



(49, 19, 'notification', '{"eventId": 49, "kind": "MESSAGE", "message": "실시간 이번트 49가 도착했습니다."}'::jsonb, '2026-06-22 11:05:00'),



(50, 20, 'message', '{"eventId": 50, "kind": "LIKE", "message": "실시간 이번트 50가 도착했습니다."}'::jsonb, '2026-06-23 11:05:00'),



(51, 21, 'notification', '{"eventId": 51, "kind": "BOOKMARK", "message": "실시간 이번트 51가 도착했습니다."}'::jsonb, '2026-06-24 11:05:00'),



(52, 22, 'message', '{"eventId": 52, "kind": "COMMENT", "message": "실시간 이번트 52가 도착했습니다."}'::jsonb, '2026-06-25 11:05:00'),



(53, 23, 'notification', '{"eventId": 53, "kind": "AI", "message": "실시간 이번트 53가 도착했습니다."}'::jsonb, '2026-06-26 11:05:00'),



(54, 24, 'message', '{"eventId": 54, "kind": "SYSTEM", "message": "실시간 이번트 54가 도착했습니다."}'::jsonb, '2026-06-27 11:05:00'),



(55, 25, 'notification', '{"eventId": 55, "kind": "MESSAGE", "message": "실시간 이번트 55가 도착했습니다."}'::jsonb, '2026-06-28 11:05:00'),



(56, 26, 'message', '{"eventId": 56, "kind": "LIKE", "message": "실시간 이번트 56가 도착했습니다."}'::jsonb, '2026-06-01 11:05:00'),



(57, 27, 'notification', '{"eventId": 57, "kind": "BOOKMARK", "message": "실시간 이번트 57가 도착했습니다."}'::jsonb, '2026-06-02 11:05:00'),



(58, 28, 'message', '{"eventId": 58, "kind": "COMMENT", "message": "실시간 이번트 58가 도착했습니다."}'::jsonb, '2026-06-03 11:05:00'),



(59, 29, 'notification', '{"eventId": 59, "kind": "AI", "message": "실시간 이번트 59가 도착했습니다."}'::jsonb, '2026-06-04 11:05:00'),



(60, 30, 'message', '{"eventId": 60, "kind": "SYSTEM", "message": "실시간 이번트 60가 도착했습니다."}'::jsonb, '2026-06-05 11:05:00'),



(61, 1, 'notification', '{"eventId": 61, "kind": "MESSAGE", "message": "실시간 이번트 61가 도착했습니다."}'::jsonb, '2026-06-06 11:05:00'),



(62, 2, 'message', '{"eventId": 62, "kind": "LIKE", "message": "실시간 이번트 62가 도착했습니다."}'::jsonb, '2026-06-07 11:05:00'),



(63, 3, 'notification', '{"eventId": 63, "kind": "BOOKMARK", "message": "실시간 이번트 63가 도착했습니다."}'::jsonb, '2026-06-08 11:05:00'),



(64, 4, 'message', '{"eventId": 64, "kind": "COMMENT", "message": "실시간 이번트 64가 도착했습니다."}'::jsonb, '2026-06-09 11:05:00'),



(65, 5, 'notification', '{"eventId": 65, "kind": "AI", "message": "실시간 이번트 65가 도착했습니다."}'::jsonb, '2026-06-10 11:05:00'),



(66, 6, 'message', '{"eventId": 66, "kind": "SYSTEM", "message": "실시간 이번트 66가 도착했습니다."}'::jsonb, '2026-06-11 11:05:00'),



(67, 7, 'notification', '{"eventId": 67, "kind": "MESSAGE", "message": "실시간 이번트 67가 도착했습니다."}'::jsonb, '2026-06-12 11:05:00'),



(68, 8, 'message', '{"eventId": 68, "kind": "LIKE", "message": "실시간 이번트 68가 도착했습니다."}'::jsonb, '2026-06-13 11:05:00'),



(69, 9, 'notification', '{"eventId": 69, "kind": "BOOKMARK", "message": "실시간 이번트 69가 도착했습니다."}'::jsonb, '2026-06-14 11:05:00'),



(70, 10, 'message', '{"eventId": 70, "kind": "COMMENT", "message": "실시간 이번트 70가 도착했습니다."}'::jsonb, '2026-06-15 11:05:00'),



(71, 11, 'notification', '{"eventId": 71, "kind": "AI", "message": "실시간 이번트 71가 도착했습니다."}'::jsonb, '2026-06-16 11:05:00'),



(72, 12, 'message', '{"eventId": 72, "kind": "SYSTEM", "message": "실시간 이번트 72가 도착했습니다."}'::jsonb, '2026-06-17 11:05:00'),



(73, 13, 'notification', '{"eventId": 73, "kind": "MESSAGE", "message": "실시간 이번트 73가 도착했습니다."}'::jsonb, '2026-06-18 11:05:00'),



(74, 14, 'message', '{"eventId": 74, "kind": "LIKE", "message": "실시간 이번트 74가 도착했습니다."}'::jsonb, '2026-06-19 11:05:00'),



(75, 15, 'notification', '{"eventId": 75, "kind": "BOOKMARK", "message": "실시간 이번트 75가 도착했습니다."}'::jsonb, '2026-06-20 11:05:00'),



(76, 16, 'message', '{"eventId": 76, "kind": "COMMENT", "message": "실시간 이번트 76가 도착했습니다."}'::jsonb, '2026-06-21 11:05:00'),



(77, 17, 'notification', '{"eventId": 77, "kind": "AI", "message": "실시간 이번트 77가 도착했습니다."}'::jsonb, '2026-06-22 11:05:00'),



(78, 18, 'message', '{"eventId": 78, "kind": "SYSTEM", "message": "실시간 이번트 78가 도착했습니다."}'::jsonb, '2026-06-23 11:05:00'),



(79, 19, 'notification', '{"eventId": 79, "kind": "MESSAGE", "message": "실시간 이번트 79가 도착했습니다."}'::jsonb, '2026-06-24 11:05:00'),



(80, 20, 'message', '{"eventId": 80, "kind": "LIKE", "message": "실시간 이번트 80가 도착했습니다."}'::jsonb, '2026-06-25 11:05:00'),



(81, 21, 'notification', '{"eventId": 81, "kind": "BOOKMARK", "message": "실시간 이번트 81가 도착했습니다."}'::jsonb, '2026-06-26 11:05:00'),



(82, 22, 'message', '{"eventId": 82, "kind": "COMMENT", "message": "실시간 이번트 82가 도착했습니다."}'::jsonb, '2026-06-27 11:05:00'),



(83, 23, 'notification', '{"eventId": 83, "kind": "AI", "message": "실시간 이번트 83가 도착했습니다."}'::jsonb, '2026-06-28 11:05:00'),



(84, 24, 'message', '{"eventId": 84, "kind": "SYSTEM", "message": "실시간 이번트 84가 도착했습니다."}'::jsonb, '2026-06-01 11:05:00'),



(85, 25, 'notification', '{"eventId": 85, "kind": "MESSAGE", "message": "실시간 이번트 85가 도착했습니다."}'::jsonb, '2026-06-02 11:05:00'),



(86, 26, 'message', '{"eventId": 86, "kind": "LIKE", "message": "실시간 이번트 86가 도착했습니다."}'::jsonb, '2026-06-03 11:05:00'),



(87, 27, 'notification', '{"eventId": 87, "kind": "BOOKMARK", "message": "실시간 이번트 87가 도착했습니다."}'::jsonb, '2026-06-04 11:05:00'),



(88, 28, 'message', '{"eventId": 88, "kind": "COMMENT", "message": "실시간 이번트 88가 도착했습니다."}'::jsonb, '2026-06-05 11:05:00'),



(89, 29, 'notification', '{"eventId": 89, "kind": "AI", "message": "실시간 이번트 89가 도착했습니다."}'::jsonb, '2026-06-06 11:05:00'),



(90, 30, 'message', '{"eventId": 90, "kind": "SYSTEM", "message": "실시간 이번트 90가 도착했습니다."}'::jsonb, '2026-06-07 11:05:00'),



(91, 1, 'notification', '{"eventId": 91, "kind": "MESSAGE", "message": "실시간 이번트 91가 도착했습니다."}'::jsonb, '2026-06-08 11:05:00'),



(92, 2, 'message', '{"eventId": 92, "kind": "LIKE", "message": "실시간 이번트 92가 도착했습니다."}'::jsonb, '2026-06-09 11:05:00'),



(93, 3, 'notification', '{"eventId": 93, "kind": "BOOKMARK", "message": "실시간 이번트 93가 도착했습니다."}'::jsonb, '2026-06-10 11:05:00'),



(94, 4, 'message', '{"eventId": 94, "kind": "COMMENT", "message": "실시간 이번트 94가 도착했습니다."}'::jsonb, '2026-06-11 11:05:00'),



(95, 5, 'notification', '{"eventId": 95, "kind": "AI", "message": "실시간 이번트 95가 도착했습니다."}'::jsonb, '2026-06-12 11:05:00'),



(96, 6, 'message', '{"eventId": 96, "kind": "SYSTEM", "message": "실시간 이번트 96가 도착했습니다."}'::jsonb, '2026-06-13 11:05:00'),



(97, 7, 'notification', '{"eventId": 97, "kind": "MESSAGE", "message": "실시간 이번트 97가 도착했습니다."}'::jsonb, '2026-06-14 11:05:00'),



(98, 8, 'message', '{"eventId": 98, "kind": "LIKE", "message": "실시간 이번트 98가 도착했습니다."}'::jsonb, '2026-06-15 11:05:00'),



(99, 9, 'notification', '{"eventId": 99, "kind": "BOOKMARK", "message": "실시간 이번트 99가 도착했습니다."}'::jsonb, '2026-06-16 11:05:00'),



(100, 10, 'message', '{"eventId": 100, "kind": "COMMENT", "message": "실시간 이번트 100가 도착했습니다."}'::jsonb, '2026-06-17 11:05:00');



INSERT INTO realtime_events (id, user_id, event_type, payload, created_at) VALUES



(101, 11, 'notification', '{"eventId": 101, "kind": "AI", "message": "실시간 이번트 101가 도착했습니다."}'::jsonb, '2026-06-18 11:05:00'),



(102, 12, 'message', '{"eventId": 102, "kind": "SYSTEM", "message": "실시간 이번트 102가 도착했습니다."}'::jsonb, '2026-06-19 11:05:00'),



(103, 13, 'notification', '{"eventId": 103, "kind": "MESSAGE", "message": "실시간 이번트 103가 도착했습니다."}'::jsonb, '2026-06-20 11:05:00'),



(104, 14, 'message', '{"eventId": 104, "kind": "LIKE", "message": "실시간 이번트 104가 도착했습니다."}'::jsonb, '2026-06-21 11:05:00'),



(105, 15, 'notification', '{"eventId": 105, "kind": "BOOKMARK", "message": "실시간 이번트 105가 도착했습니다."}'::jsonb, '2026-06-22 11:05:00'),



(106, 16, 'message', '{"eventId": 106, "kind": "COMMENT", "message": "실시간 이번트 106가 도착했습니다."}'::jsonb, '2026-06-23 11:05:00'),



(107, 17, 'notification', '{"eventId": 107, "kind": "AI", "message": "실시간 이번트 107가 도착했습니다."}'::jsonb, '2026-06-24 11:05:00'),



(108, 18, 'message', '{"eventId": 108, "kind": "SYSTEM", "message": "실시간 이번트 108가 도착했습니다."}'::jsonb, '2026-06-25 11:05:00'),



(109, 19, 'notification', '{"eventId": 109, "kind": "MESSAGE", "message": "실시간 이번트 109가 도착했습니다."}'::jsonb, '2026-06-26 11:05:00'),



(110, 20, 'message', '{"eventId": 110, "kind": "LIKE", "message": "실시간 이번트 110가 도착했습니다."}'::jsonb, '2026-06-27 11:05:00'),



(111, 21, 'notification', '{"eventId": 111, "kind": "BOOKMARK", "message": "실시간 이번트 111가 도착했습니다."}'::jsonb, '2026-06-28 11:05:00'),



(112, 22, 'message', '{"eventId": 112, "kind": "COMMENT", "message": "실시간 이번트 112가 도착했습니다."}'::jsonb, '2026-06-01 11:05:00'),



(113, 23, 'notification', '{"eventId": 113, "kind": "AI", "message": "실시간 이번트 113가 도착했습니다."}'::jsonb, '2026-06-02 11:05:00'),



(114, 24, 'message', '{"eventId": 114, "kind": "SYSTEM", "message": "실시간 이번트 114가 도착했습니다."}'::jsonb, '2026-06-03 11:05:00'),



(115, 25, 'notification', '{"eventId": 115, "kind": "MESSAGE", "message": "실시간 이번트 115가 도착했습니다."}'::jsonb, '2026-06-04 11:05:00'),



(116, 26, 'message', '{"eventId": 116, "kind": "LIKE", "message": "실시간 이번트 116가 도착했습니다."}'::jsonb, '2026-06-05 11:05:00'),



(117, 27, 'notification', '{"eventId": 117, "kind": "BOOKMARK", "message": "실시간 이번트 117가 도착했습니다."}'::jsonb, '2026-06-06 11:05:00'),



(118, 28, 'message', '{"eventId": 118, "kind": "COMMENT", "message": "실시간 이번트 118가 도착했습니다."}'::jsonb, '2026-06-07 11:05:00'),



(119, 29, 'notification', '{"eventId": 119, "kind": "AI", "message": "실시간 이번트 119가 도착했습니다."}'::jsonb, '2026-06-08 11:05:00'),



(120, 30, 'message', '{"eventId": 120, "kind": "SYSTEM", "message": "실시간 이번트 120가 도착했습니다."}'::jsonb, '2026-06-09 11:05:00'),



(121, 1, 'notification', '{"eventId": 121, "kind": "MESSAGE", "message": "실시간 이번트 121가 도착했습니다."}'::jsonb, '2026-06-10 11:05:00'),



(122, 2, 'message', '{"eventId": 122, "kind": "LIKE", "message": "실시간 이번트 122가 도착했습니다."}'::jsonb, '2026-06-11 11:05:00'),



(123, 3, 'notification', '{"eventId": 123, "kind": "BOOKMARK", "message": "실시간 이번트 123가 도착했습니다."}'::jsonb, '2026-06-12 11:05:00'),



(124, 4, 'message', '{"eventId": 124, "kind": "COMMENT", "message": "실시간 이번트 124가 도착했습니다."}'::jsonb, '2026-06-13 11:05:00'),



(125, 5, 'notification', '{"eventId": 125, "kind": "AI", "message": "실시간 이번트 125가 도착했습니다."}'::jsonb, '2026-06-14 11:05:00'),



(126, 6, 'message', '{"eventId": 126, "kind": "SYSTEM", "message": "실시간 이번트 126가 도착했습니다."}'::jsonb, '2026-06-15 11:05:00'),



(127, 7, 'notification', '{"eventId": 127, "kind": "MESSAGE", "message": "실시간 이번트 127가 도착했습니다."}'::jsonb, '2026-06-16 11:05:00'),



(128, 8, 'message', '{"eventId": 128, "kind": "LIKE", "message": "실시간 이번트 128가 도착했습니다."}'::jsonb, '2026-06-17 11:05:00'),



(129, 9, 'notification', '{"eventId": 129, "kind": "BOOKMARK", "message": "실시간 이번트 129가 도착했습니다."}'::jsonb, '2026-06-18 11:05:00'),



(130, 10, 'message', '{"eventId": 130, "kind": "COMMENT", "message": "실시간 이번트 130가 도착했습니다."}'::jsonb, '2026-06-19 11:05:00'),



(131, 11, 'notification', '{"eventId": 131, "kind": "AI", "message": "실시간 이번트 131가 도착했습니다."}'::jsonb, '2026-06-20 11:05:00'),



(132, 12, 'message', '{"eventId": 132, "kind": "SYSTEM", "message": "실시간 이번트 132가 도착했습니다."}'::jsonb, '2026-06-21 11:05:00'),



(133, 13, 'notification', '{"eventId": 133, "kind": "MESSAGE", "message": "실시간 이번트 133가 도착했습니다."}'::jsonb, '2026-06-22 11:05:00'),



(134, 14, 'message', '{"eventId": 134, "kind": "LIKE", "message": "실시간 이번트 134가 도착했습니다."}'::jsonb, '2026-06-23 11:05:00'),



(135, 15, 'notification', '{"eventId": 135, "kind": "BOOKMARK", "message": "실시간 이번트 135가 도착했습니다."}'::jsonb, '2026-06-24 11:05:00'),



(136, 16, 'message', '{"eventId": 136, "kind": "COMMENT", "message": "실시간 이번트 136가 도착했습니다."}'::jsonb, '2026-06-25 11:05:00'),



(137, 17, 'notification', '{"eventId": 137, "kind": "AI", "message": "실시간 이번트 137가 도착했습니다."}'::jsonb, '2026-06-26 11:05:00'),



(138, 18, 'message', '{"eventId": 138, "kind": "SYSTEM", "message": "실시간 이번트 138가 도착했습니다."}'::jsonb, '2026-06-27 11:05:00'),



(139, 19, 'notification', '{"eventId": 139, "kind": "MESSAGE", "message": "실시간 이번트 139가 도착했습니다."}'::jsonb, '2026-06-28 11:05:00'),



(140, 20, 'message', '{"eventId": 140, "kind": "LIKE", "message": "실시간 이번트 140가 도착했습니다."}'::jsonb, '2026-06-01 11:05:00'),



(141, 21, 'notification', '{"eventId": 141, "kind": "BOOKMARK", "message": "실시간 이번트 141가 도착했습니다."}'::jsonb, '2026-06-02 11:05:00'),



(142, 22, 'message', '{"eventId": 142, "kind": "COMMENT", "message": "실시간 이번트 142가 도착했습니다."}'::jsonb, '2026-06-03 11:05:00'),



(143, 23, 'notification', '{"eventId": 143, "kind": "AI", "message": "실시간 이번트 143가 도착했습니다."}'::jsonb, '2026-06-04 11:05:00'),



(144, 24, 'message', '{"eventId": 144, "kind": "SYSTEM", "message": "실시간 이번트 144가 도착했습니다."}'::jsonb, '2026-06-05 11:05:00'),



(145, 25, 'notification', '{"eventId": 145, "kind": "MESSAGE", "message": "실시간 이번트 145가 도착했습니다."}'::jsonb, '2026-06-06 11:05:00'),



(146, 26, 'message', '{"eventId": 146, "kind": "LIKE", "message": "실시간 이번트 146가 도착했습니다."}'::jsonb, '2026-06-07 11:05:00'),



(147, 27, 'notification', '{"eventId": 147, "kind": "BOOKMARK", "message": "실시간 이번트 147가 도착했습니다."}'::jsonb, '2026-06-08 11:05:00'),



(148, 28, 'message', '{"eventId": 148, "kind": "COMMENT", "message": "실시간 이번트 148가 도착했습니다."}'::jsonb, '2026-06-09 11:05:00'),



(149, 29, 'notification', '{"eventId": 149, "kind": "AI", "message": "실시간 이번트 149가 도착했습니다."}'::jsonb, '2026-06-10 11:05:00'),



(150, 30, 'message', '{"eventId": 150, "kind": "SYSTEM", "message": "실시간 이번트 150가 도착했습니다."}'::jsonb, '2026-06-11 11:05:00'),



(151, 1, 'notification', '{"eventId": 151, "kind": "MESSAGE", "message": "실시간 이번트 151가 도착했습니다."}'::jsonb, '2026-06-12 11:05:00'),



(152, 2, 'message', '{"eventId": 152, "kind": "LIKE", "message": "실시간 이번트 152가 도착했습니다."}'::jsonb, '2026-06-13 11:05:00'),



(153, 3, 'notification', '{"eventId": 153, "kind": "BOOKMARK", "message": "실시간 이번트 153가 도착했습니다."}'::jsonb, '2026-06-14 11:05:00'),



(154, 4, 'message', '{"eventId": 154, "kind": "COMMENT", "message": "실시간 이번트 154가 도착했습니다."}'::jsonb, '2026-06-15 11:05:00'),



(155, 5, 'notification', '{"eventId": 155, "kind": "AI", "message": "실시간 이번트 155가 도착했습니다."}'::jsonb, '2026-06-16 11:05:00'),



(156, 6, 'message', '{"eventId": 156, "kind": "SYSTEM", "message": "실시간 이번트 156가 도착했습니다."}'::jsonb, '2026-06-17 11:05:00'),



(157, 7, 'notification', '{"eventId": 157, "kind": "MESSAGE", "message": "실시간 이번트 157가 도착했습니다."}'::jsonb, '2026-06-18 11:05:00'),



(158, 8, 'message', '{"eventId": 158, "kind": "LIKE", "message": "실시간 이번트 158가 도착했습니다."}'::jsonb, '2026-06-19 11:05:00'),



(159, 9, 'notification', '{"eventId": 159, "kind": "BOOKMARK", "message": "실시간 이번트 159가 도착했습니다."}'::jsonb, '2026-06-20 11:05:00'),



(160, 10, 'message', '{"eventId": 160, "kind": "COMMENT", "message": "실시간 이번트 160가 도착했습니다."}'::jsonb, '2026-06-21 11:05:00'),



(161, 11, 'notification', '{"eventId": 161, "kind": "AI", "message": "실시간 이번트 161가 도착했습니다."}'::jsonb, '2026-06-22 11:05:00'),



(162, 12, 'message', '{"eventId": 162, "kind": "SYSTEM", "message": "실시간 이번트 162가 도착했습니다."}'::jsonb, '2026-06-23 11:05:00'),



(163, 13, 'notification', '{"eventId": 163, "kind": "MESSAGE", "message": "실시간 이번트 163가 도착했습니다."}'::jsonb, '2026-06-24 11:05:00'),



(164, 14, 'message', '{"eventId": 164, "kind": "LIKE", "message": "실시간 이번트 164가 도착했습니다."}'::jsonb, '2026-06-25 11:05:00'),



(165, 15, 'notification', '{"eventId": 165, "kind": "BOOKMARK", "message": "실시간 이번트 165가 도착했습니다."}'::jsonb, '2026-06-26 11:05:00'),



(166, 16, 'message', '{"eventId": 166, "kind": "COMMENT", "message": "실시간 이번트 166가 도착했습니다."}'::jsonb, '2026-06-27 11:05:00'),



(167, 17, 'notification', '{"eventId": 167, "kind": "AI", "message": "실시간 이번트 167가 도착했습니다."}'::jsonb, '2026-06-28 11:05:00'),



(168, 18, 'message', '{"eventId": 168, "kind": "SYSTEM", "message": "실시간 이번트 168가 도착했습니다."}'::jsonb, '2026-06-01 11:05:00'),



(169, 19, 'notification', '{"eventId": 169, "kind": "MESSAGE", "message": "실시간 이번트 169가 도착했습니다."}'::jsonb, '2026-06-02 11:05:00'),



(170, 20, 'message', '{"eventId": 170, "kind": "LIKE", "message": "실시간 이번트 170가 도착했습니다."}'::jsonb, '2026-06-03 11:05:00'),



(171, 21, 'notification', '{"eventId": 171, "kind": "BOOKMARK", "message": "실시간 이번트 171가 도착했습니다."}'::jsonb, '2026-06-04 11:05:00'),



(172, 22, 'message', '{"eventId": 172, "kind": "COMMENT", "message": "실시간 이번트 172가 도착했습니다."}'::jsonb, '2026-06-05 11:05:00'),



(173, 23, 'notification', '{"eventId": 173, "kind": "AI", "message": "실시간 이번트 173가 도착했습니다."}'::jsonb, '2026-06-06 11:05:00'),



(174, 24, 'message', '{"eventId": 174, "kind": "SYSTEM", "message": "실시간 이번트 174가 도착했습니다."}'::jsonb, '2026-06-07 11:05:00'),



(175, 25, 'notification', '{"eventId": 175, "kind": "MESSAGE", "message": "실시간 이번트 175가 도착했습니다."}'::jsonb, '2026-06-08 11:05:00'),



(176, 26, 'message', '{"eventId": 176, "kind": "LIKE", "message": "실시간 이번트 176가 도착했습니다."}'::jsonb, '2026-06-09 11:05:00'),



(177, 27, 'notification', '{"eventId": 177, "kind": "BOOKMARK", "message": "실시간 이번트 177가 도착했습니다."}'::jsonb, '2026-06-10 11:05:00'),



(178, 28, 'message', '{"eventId": 178, "kind": "COMMENT", "message": "실시간 이번트 178가 도착했습니다."}'::jsonb, '2026-06-11 11:05:00'),



(179, 29, 'notification', '{"eventId": 179, "kind": "AI", "message": "실시간 이번트 179가 도착했습니다."}'::jsonb, '2026-06-12 11:05:00'),



(180, 30, 'message', '{"eventId": 180, "kind": "SYSTEM", "message": "실시간 이번트 180가 도착했습니다."}'::jsonb, '2026-06-13 11:05:00'),



(181, 1, 'notification', '{"eventId": 181, "kind": "MESSAGE", "message": "실시간 이번트 181가 도착했습니다."}'::jsonb, '2026-06-14 11:05:00'),



(182, 2, 'message', '{"eventId": 182, "kind": "LIKE", "message": "실시간 이번트 182가 도착했습니다."}'::jsonb, '2026-06-15 11:05:00'),



(183, 3, 'notification', '{"eventId": 183, "kind": "BOOKMARK", "message": "실시간 이번트 183가 도착했습니다."}'::jsonb, '2026-06-16 11:05:00'),



(184, 4, 'message', '{"eventId": 184, "kind": "COMMENT", "message": "실시간 이번트 184가 도착했습니다."}'::jsonb, '2026-06-17 11:05:00'),



(185, 5, 'notification', '{"eventId": 185, "kind": "AI", "message": "실시간 이번트 185가 도착했습니다."}'::jsonb, '2026-06-18 11:05:00'),



(186, 6, 'message', '{"eventId": 186, "kind": "SYSTEM", "message": "실시간 이번트 186가 도착했습니다."}'::jsonb, '2026-06-19 11:05:00'),



(187, 7, 'notification', '{"eventId": 187, "kind": "MESSAGE", "message": "실시간 이번트 187가 도착했습니다."}'::jsonb, '2026-06-20 11:05:00'),



(188, 8, 'message', '{"eventId": 188, "kind": "LIKE", "message": "실시간 이번트 188가 도착했습니다."}'::jsonb, '2026-06-21 11:05:00'),



(189, 9, 'notification', '{"eventId": 189, "kind": "BOOKMARK", "message": "실시간 이번트 189가 도착했습니다."}'::jsonb, '2026-06-22 11:05:00'),



(190, 10, 'message', '{"eventId": 190, "kind": "COMMENT", "message": "실시간 이번트 190가 도착했습니다."}'::jsonb, '2026-06-23 11:05:00'),



(191, 11, 'notification', '{"eventId": 191, "kind": "AI", "message": "실시간 이번트 191가 도착했습니다."}'::jsonb, '2026-06-24 11:05:00'),



(192, 12, 'message', '{"eventId": 192, "kind": "SYSTEM", "message": "실시간 이번트 192가 도착했습니다."}'::jsonb, '2026-06-25 11:05:00'),



(193, 13, 'notification', '{"eventId": 193, "kind": "MESSAGE", "message": "실시간 이번트 193가 도착했습니다."}'::jsonb, '2026-06-26 11:05:00'),



(194, 14, 'message', '{"eventId": 194, "kind": "LIKE", "message": "실시간 이번트 194가 도착했습니다."}'::jsonb, '2026-06-27 11:05:00'),



(195, 15, 'notification', '{"eventId": 195, "kind": "BOOKMARK", "message": "실시간 이번트 195가 도착했습니다."}'::jsonb, '2026-06-28 11:05:00'),



(196, 16, 'message', '{"eventId": 196, "kind": "COMMENT", "message": "실시간 이번트 196가 도착했습니다."}'::jsonb, '2026-06-01 11:05:00'),



(197, 17, 'notification', '{"eventId": 197, "kind": "AI", "message": "실시간 이번트 197가 도착했습니다."}'::jsonb, '2026-06-02 11:05:00'),



(198, 18, 'message', '{"eventId": 198, "kind": "SYSTEM", "message": "실시간 이번트 198가 도착했습니다."}'::jsonb, '2026-06-03 11:05:00'),



(199, 19, 'notification', '{"eventId": 199, "kind": "MESSAGE", "message": "실시간 이번트 199가 도착했습니다."}'::jsonb, '2026-06-04 11:05:00'),



(200, 20, 'message', '{"eventId": 200, "kind": "LIKE", "message": "실시간 이번트 200가 도착했습니다."}'::jsonb, '2026-06-05 11:05:00');



INSERT INTO realtime_events (id, user_id, event_type, payload, created_at) VALUES



(201, 21, 'notification', '{"eventId": 201, "kind": "BOOKMARK", "message": "실시간 이번트 201가 도착했습니다."}'::jsonb, '2026-06-06 11:05:00'),



(202, 22, 'message', '{"eventId": 202, "kind": "COMMENT", "message": "실시간 이번트 202가 도착했습니다."}'::jsonb, '2026-06-07 11:05:00'),



(203, 23, 'notification', '{"eventId": 203, "kind": "AI", "message": "실시간 이번트 203가 도착했습니다."}'::jsonb, '2026-06-08 11:05:00'),



(204, 24, 'message', '{"eventId": 204, "kind": "SYSTEM", "message": "실시간 이번트 204가 도착했습니다."}'::jsonb, '2026-06-09 11:05:00'),



(205, 25, 'notification', '{"eventId": 205, "kind": "MESSAGE", "message": "실시간 이번트 205가 도착했습니다."}'::jsonb, '2026-06-10 11:05:00'),



(206, 26, 'message', '{"eventId": 206, "kind": "LIKE", "message": "실시간 이번트 206가 도착했습니다."}'::jsonb, '2026-06-11 11:05:00'),



(207, 27, 'notification', '{"eventId": 207, "kind": "BOOKMARK", "message": "실시간 이번트 207가 도착했습니다."}'::jsonb, '2026-06-12 11:05:00'),



(208, 28, 'message', '{"eventId": 208, "kind": "COMMENT", "message": "실시간 이번트 208가 도착했습니다."}'::jsonb, '2026-06-13 11:05:00'),



(209, 29, 'notification', '{"eventId": 209, "kind": "AI", "message": "실시간 이번트 209가 도착했습니다."}'::jsonb, '2026-06-14 11:05:00'),



(210, 30, 'message', '{"eventId": 210, "kind": "SYSTEM", "message": "실시간 이번트 210가 도착했습니다."}'::jsonb, '2026-06-15 11:05:00'),



(211, 1, 'notification', '{"eventId": 211, "kind": "MESSAGE", "message": "실시간 이번트 211가 도착했습니다."}'::jsonb, '2026-06-16 11:05:00'),



(212, 2, 'message', '{"eventId": 212, "kind": "LIKE", "message": "실시간 이번트 212가 도착했습니다."}'::jsonb, '2026-06-17 11:05:00'),



(213, 3, 'notification', '{"eventId": 213, "kind": "BOOKMARK", "message": "실시간 이번트 213가 도착했습니다."}'::jsonb, '2026-06-18 11:05:00'),



(214, 4, 'message', '{"eventId": 214, "kind": "COMMENT", "message": "실시간 이번트 214가 도착했습니다."}'::jsonb, '2026-06-19 11:05:00'),



(215, 5, 'notification', '{"eventId": 215, "kind": "AI", "message": "실시간 이번트 215가 도착했습니다."}'::jsonb, '2026-06-20 11:05:00'),



(216, 6, 'message', '{"eventId": 216, "kind": "SYSTEM", "message": "실시간 이번트 216가 도착했습니다."}'::jsonb, '2026-06-21 11:05:00'),



(217, 7, 'notification', '{"eventId": 217, "kind": "MESSAGE", "message": "실시간 이번트 217가 도착했습니다."}'::jsonb, '2026-06-22 11:05:00'),



(218, 8, 'message', '{"eventId": 218, "kind": "LIKE", "message": "실시간 이번트 218가 도착했습니다."}'::jsonb, '2026-06-23 11:05:00'),



(219, 9, 'notification', '{"eventId": 219, "kind": "BOOKMARK", "message": "실시간 이번트 219가 도착했습니다."}'::jsonb, '2026-06-24 11:05:00'),



(220, 10, 'message', '{"eventId": 220, "kind": "COMMENT", "message": "실시간 이번트 220가 도착했습니다."}'::jsonb, '2026-06-25 11:05:00'),



(221, 11, 'notification', '{"eventId": 221, "kind": "AI", "message": "실시간 이번트 221가 도착했습니다."}'::jsonb, '2026-06-26 11:05:00'),



(222, 12, 'message', '{"eventId": 222, "kind": "SYSTEM", "message": "실시간 이번트 222가 도착했습니다."}'::jsonb, '2026-06-27 11:05:00'),



(223, 13, 'notification', '{"eventId": 223, "kind": "MESSAGE", "message": "실시간 이번트 223가 도착했습니다."}'::jsonb, '2026-06-28 11:05:00'),



(224, 14, 'message', '{"eventId": 224, "kind": "LIKE", "message": "실시간 이번트 224가 도착했습니다."}'::jsonb, '2026-06-01 11:05:00'),



(225, 15, 'notification', '{"eventId": 225, "kind": "BOOKMARK", "message": "실시간 이번트 225가 도착했습니다."}'::jsonb, '2026-06-02 11:05:00'),



(226, 16, 'message', '{"eventId": 226, "kind": "COMMENT", "message": "실시간 이번트 226가 도착했습니다."}'::jsonb, '2026-06-03 11:05:00'),



(227, 17, 'notification', '{"eventId": 227, "kind": "AI", "message": "실시간 이번트 227가 도착했습니다."}'::jsonb, '2026-06-04 11:05:00'),



(228, 18, 'message', '{"eventId": 228, "kind": "SYSTEM", "message": "실시간 이번트 228가 도착했습니다."}'::jsonb, '2026-06-05 11:05:00'),



(229, 19, 'notification', '{"eventId": 229, "kind": "MESSAGE", "message": "실시간 이번트 229가 도착했습니다."}'::jsonb, '2026-06-06 11:05:00'),



(230, 20, 'message', '{"eventId": 230, "kind": "LIKE", "message": "실시간 이번트 230가 도착했습니다."}'::jsonb, '2026-06-07 11:05:00'),



(231, 21, 'notification', '{"eventId": 231, "kind": "BOOKMARK", "message": "실시간 이번트 231가 도착했습니다."}'::jsonb, '2026-06-08 11:05:00'),



(232, 22, 'message', '{"eventId": 232, "kind": "COMMENT", "message": "실시간 이번트 232가 도착했습니다."}'::jsonb, '2026-06-09 11:05:00'),



(233, 23, 'notification', '{"eventId": 233, "kind": "AI", "message": "실시간 이번트 233가 도착했습니다."}'::jsonb, '2026-06-10 11:05:00'),



(234, 24, 'message', '{"eventId": 234, "kind": "SYSTEM", "message": "실시간 이번트 234가 도착했습니다."}'::jsonb, '2026-06-11 11:05:00'),



(235, 25, 'notification', '{"eventId": 235, "kind": "MESSAGE", "message": "실시간 이번트 235가 도착했습니다."}'::jsonb, '2026-06-12 11:05:00'),



(236, 26, 'message', '{"eventId": 236, "kind": "LIKE", "message": "실시간 이번트 236가 도착했습니다."}'::jsonb, '2026-06-13 11:05:00'),



(237, 27, 'notification', '{"eventId": 237, "kind": "BOOKMARK", "message": "실시간 이번트 237가 도착했습니다."}'::jsonb, '2026-06-14 11:05:00'),



(238, 28, 'message', '{"eventId": 238, "kind": "COMMENT", "message": "실시간 이번트 238가 도착했습니다."}'::jsonb, '2026-06-15 11:05:00'),



(239, 29, 'notification', '{"eventId": 239, "kind": "AI", "message": "실시간 이번트 239가 도착했습니다."}'::jsonb, '2026-06-16 11:05:00'),



(240, 30, 'message', '{"eventId": 240, "kind": "SYSTEM", "message": "실시간 이번트 240가 도착했습니다."}'::jsonb, '2026-06-17 11:05:00'),



(241, 1, 'notification', '{"eventId": 241, "kind": "MESSAGE", "message": "실시간 이번트 241가 도착했습니다."}'::jsonb, '2026-06-18 11:05:00'),



(242, 2, 'message', '{"eventId": 242, "kind": "LIKE", "message": "실시간 이번트 242가 도착했습니다."}'::jsonb, '2026-06-19 11:05:00'),



(243, 3, 'notification', '{"eventId": 243, "kind": "BOOKMARK", "message": "실시간 이번트 243가 도착했습니다."}'::jsonb, '2026-06-20 11:05:00'),



(244, 4, 'message', '{"eventId": 244, "kind": "COMMENT", "message": "실시간 이번트 244가 도착했습니다."}'::jsonb, '2026-06-21 11:05:00'),



(245, 5, 'notification', '{"eventId": 245, "kind": "AI", "message": "실시간 이번트 245가 도착했습니다."}'::jsonb, '2026-06-22 11:05:00'),



(246, 6, 'message', '{"eventId": 246, "kind": "SYSTEM", "message": "실시간 이번트 246가 도착했습니다."}'::jsonb, '2026-06-23 11:05:00'),



(247, 7, 'notification', '{"eventId": 247, "kind": "MESSAGE", "message": "실시간 이번트 247가 도착했습니다."}'::jsonb, '2026-06-24 11:05:00'),



(248, 8, 'message', '{"eventId": 248, "kind": "LIKE", "message": "실시간 이번트 248가 도착했습니다."}'::jsonb, '2026-06-25 11:05:00'),



(249, 9, 'notification', '{"eventId": 249, "kind": "BOOKMARK", "message": "실시간 이번트 249가 도착했습니다."}'::jsonb, '2026-06-26 11:05:00'),



(250, 10, 'message', '{"eventId": 250, "kind": "COMMENT", "message": "실시간 이번트 250가 도착했습니다."}'::jsonb, '2026-06-27 11:05:00'),



(251, 11, 'notification', '{"eventId": 251, "kind": "AI", "message": "실시간 이번트 251가 도착했습니다."}'::jsonb, '2026-06-28 11:05:00'),



(252, 12, 'message', '{"eventId": 252, "kind": "SYSTEM", "message": "실시간 이번트 252가 도착했습니다."}'::jsonb, '2026-06-01 11:05:00'),



(253, 13, 'notification', '{"eventId": 253, "kind": "MESSAGE", "message": "실시간 이번트 253가 도착했습니다."}'::jsonb, '2026-06-02 11:05:00'),



(254, 14, 'message', '{"eventId": 254, "kind": "LIKE", "message": "실시간 이번트 254가 도착했습니다."}'::jsonb, '2026-06-03 11:05:00'),



(255, 15, 'notification', '{"eventId": 255, "kind": "BOOKMARK", "message": "실시간 이번트 255가 도착했습니다."}'::jsonb, '2026-06-04 11:05:00'),



(256, 16, 'message', '{"eventId": 256, "kind": "COMMENT", "message": "실시간 이번트 256가 도착했습니다."}'::jsonb, '2026-06-05 11:05:00'),



(257, 17, 'notification', '{"eventId": 257, "kind": "AI", "message": "실시간 이번트 257가 도착했습니다."}'::jsonb, '2026-06-06 11:05:00'),



(258, 18, 'message', '{"eventId": 258, "kind": "SYSTEM", "message": "실시간 이번트 258가 도착했습니다."}'::jsonb, '2026-06-07 11:05:00'),



(259, 19, 'notification', '{"eventId": 259, "kind": "MESSAGE", "message": "실시간 이번트 259가 도착했습니다."}'::jsonb, '2026-06-08 11:05:00'),



(260, 20, 'message', '{"eventId": 260, "kind": "LIKE", "message": "실시간 이번트 260가 도착했습니다."}'::jsonb, '2026-06-09 11:05:00'),



(261, 21, 'notification', '{"eventId": 261, "kind": "BOOKMARK", "message": "실시간 이번트 261가 도착했습니다."}'::jsonb, '2026-06-10 11:05:00'),



(262, 22, 'message', '{"eventId": 262, "kind": "COMMENT", "message": "실시간 이번트 262가 도착했습니다."}'::jsonb, '2026-06-11 11:05:00'),



(263, 23, 'notification', '{"eventId": 263, "kind": "AI", "message": "실시간 이번트 263가 도착했습니다."}'::jsonb, '2026-06-12 11:05:00'),



(264, 24, 'message', '{"eventId": 264, "kind": "SYSTEM", "message": "실시간 이번트 264가 도착했습니다."}'::jsonb, '2026-06-13 11:05:00'),



(265, 25, 'notification', '{"eventId": 265, "kind": "MESSAGE", "message": "실시간 이번트 265가 도착했습니다."}'::jsonb, '2026-06-14 11:05:00'),



(266, 26, 'message', '{"eventId": 266, "kind": "LIKE", "message": "실시간 이번트 266가 도착했습니다."}'::jsonb, '2026-06-15 11:05:00'),



(267, 27, 'notification', '{"eventId": 267, "kind": "BOOKMARK", "message": "실시간 이번트 267가 도착했습니다."}'::jsonb, '2026-06-16 11:05:00'),



(268, 28, 'message', '{"eventId": 268, "kind": "COMMENT", "message": "실시간 이번트 268가 도착했습니다."}'::jsonb, '2026-06-17 11:05:00'),



(269, 29, 'notification', '{"eventId": 269, "kind": "AI", "message": "실시간 이번트 269가 도착했습니다."}'::jsonb, '2026-06-18 11:05:00'),



(270, 30, 'message', '{"eventId": 270, "kind": "SYSTEM", "message": "실시간 이번트 270가 도착했습니다."}'::jsonb, '2026-06-19 11:05:00'),



(271, 1, 'notification', '{"eventId": 271, "kind": "MESSAGE", "message": "실시간 이번트 271가 도착했습니다."}'::jsonb, '2026-06-20 11:05:00'),



(272, 2, 'message', '{"eventId": 272, "kind": "LIKE", "message": "실시간 이번트 272가 도착했습니다."}'::jsonb, '2026-06-21 11:05:00'),



(273, 3, 'notification', '{"eventId": 273, "kind": "BOOKMARK", "message": "실시간 이번트 273가 도착했습니다."}'::jsonb, '2026-06-22 11:05:00'),



(274, 4, 'message', '{"eventId": 274, "kind": "COMMENT", "message": "실시간 이번트 274가 도착했습니다."}'::jsonb, '2026-06-23 11:05:00'),



(275, 5, 'notification', '{"eventId": 275, "kind": "AI", "message": "실시간 이번트 275가 도착했습니다."}'::jsonb, '2026-06-24 11:05:00'),



(276, 6, 'message', '{"eventId": 276, "kind": "SYSTEM", "message": "실시간 이번트 276가 도착했습니다."}'::jsonb, '2026-06-25 11:05:00'),



(277, 7, 'notification', '{"eventId": 277, "kind": "MESSAGE", "message": "실시간 이번트 277가 도착했습니다."}'::jsonb, '2026-06-26 11:05:00'),



(278, 8, 'message', '{"eventId": 278, "kind": "LIKE", "message": "실시간 이번트 278가 도착했습니다."}'::jsonb, '2026-06-27 11:05:00'),



(279, 9, 'notification', '{"eventId": 279, "kind": "BOOKMARK", "message": "실시간 이번트 279가 도착했습니다."}'::jsonb, '2026-06-28 11:05:00'),



(280, 10, 'message', '{"eventId": 280, "kind": "COMMENT", "message": "실시간 이번트 280가 도착했습니다."}'::jsonb, '2026-06-01 11:05:00'),



(281, 11, 'notification', '{"eventId": 281, "kind": "AI", "message": "실시간 이번트 281가 도착했습니다."}'::jsonb, '2026-06-02 11:05:00'),



(282, 12, 'message', '{"eventId": 282, "kind": "SYSTEM", "message": "실시간 이번트 282가 도착했습니다."}'::jsonb, '2026-06-03 11:05:00'),



(283, 13, 'notification', '{"eventId": 283, "kind": "MESSAGE", "message": "실시간 이번트 283가 도착했습니다."}'::jsonb, '2026-06-04 11:05:00'),



(284, 14, 'message', '{"eventId": 284, "kind": "LIKE", "message": "실시간 이번트 284가 도착했습니다."}'::jsonb, '2026-06-05 11:05:00'),



(285, 15, 'notification', '{"eventId": 285, "kind": "BOOKMARK", "message": "실시간 이번트 285가 도착했습니다."}'::jsonb, '2026-06-06 11:05:00'),



(286, 16, 'message', '{"eventId": 286, "kind": "COMMENT", "message": "실시간 이번트 286가 도착했습니다."}'::jsonb, '2026-06-07 11:05:00'),



(287, 17, 'notification', '{"eventId": 287, "kind": "AI", "message": "실시간 이번트 287가 도착했습니다."}'::jsonb, '2026-06-08 11:05:00'),



(288, 18, 'message', '{"eventId": 288, "kind": "SYSTEM", "message": "실시간 이번트 288가 도착했습니다."}'::jsonb, '2026-06-09 11:05:00'),



(289, 19, 'notification', '{"eventId": 289, "kind": "MESSAGE", "message": "실시간 이번트 289가 도착했습니다."}'::jsonb, '2026-06-10 11:05:00'),



(290, 20, 'message', '{"eventId": 290, "kind": "LIKE", "message": "실시간 이번트 290가 도착했습니다."}'::jsonb, '2026-06-11 11:05:00'),



(291, 21, 'notification', '{"eventId": 291, "kind": "BOOKMARK", "message": "실시간 이번트 291가 도착했습니다."}'::jsonb, '2026-06-12 11:05:00'),



(292, 22, 'message', '{"eventId": 292, "kind": "COMMENT", "message": "실시간 이번트 292가 도착했습니다."}'::jsonb, '2026-06-13 11:05:00'),



(293, 23, 'notification', '{"eventId": 293, "kind": "AI", "message": "실시간 이번트 293가 도착했습니다."}'::jsonb, '2026-06-14 11:05:00'),



(294, 24, 'message', '{"eventId": 294, "kind": "SYSTEM", "message": "실시간 이번트 294가 도착했습니다."}'::jsonb, '2026-06-15 11:05:00'),



(295, 25, 'notification', '{"eventId": 295, "kind": "MESSAGE", "message": "실시간 이번트 295가 도착했습니다."}'::jsonb, '2026-06-16 11:05:00'),



(296, 26, 'message', '{"eventId": 296, "kind": "LIKE", "message": "실시간 이번트 296가 도착했습니다."}'::jsonb, '2026-06-17 11:05:00'),



(297, 27, 'notification', '{"eventId": 297, "kind": "BOOKMARK", "message": "실시간 이번트 297가 도착했습니다."}'::jsonb, '2026-06-18 11:05:00'),



(298, 28, 'message', '{"eventId": 298, "kind": "COMMENT", "message": "실시간 이번트 298가 도착했습니다."}'::jsonb, '2026-06-19 11:05:00'),



(299, 29, 'notification', '{"eventId": 299, "kind": "AI", "message": "실시간 이번트 299가 도착했습니다."}'::jsonb, '2026-06-20 11:05:00'),



(300, 30, 'message', '{"eventId": 300, "kind": "SYSTEM", "message": "실시간 이번트 300가 도착했습니다."}'::jsonb, '2026-06-21 11:05:00');



INSERT INTO sse_connection_history (id, user_id, channel, connected_at, disconnected_at, last_event_id) VALUES



(1, 1, 'SSE', '2026-06-02 08:00:00', NULL, 'evt-1'),



(2, 2, 'SSE', '2026-06-03 08:00:00', NULL, 'evt-2'),



(3, 3, 'SSE', '2026-06-04 08:00:00', '2026-06-04 08:45:00', 'evt-3'),



(4, 4, 'SSE', '2026-06-05 08:00:00', NULL, 'evt-4'),



(5, 5, 'SSE', '2026-06-06 08:00:00', NULL, 'evt-5'),



(6, 6, 'SSE', '2026-06-07 08:00:00', '2026-06-07 08:45:00', 'evt-6'),



(7, 7, 'SSE', '2026-06-08 08:00:00', NULL, 'evt-7'),



(8, 8, 'SSE', '2026-06-09 08:00:00', NULL, 'evt-8'),



(9, 9, 'SSE', '2026-06-10 08:00:00', '2026-06-10 08:45:00', 'evt-9'),



(10, 10, 'SSE', '2026-06-11 08:00:00', NULL, 'evt-10'),



(11, 11, 'SSE', '2026-06-12 08:00:00', NULL, 'evt-11'),



(12, 12, 'SSE', '2026-06-13 08:00:00', '2026-06-13 08:45:00', 'evt-12'),



(13, 13, 'SSE', '2026-06-14 08:00:00', NULL, 'evt-13'),



(14, 14, 'SSE', '2026-06-15 08:00:00', NULL, 'evt-14'),



(15, 15, 'SSE', '2026-06-16 08:00:00', '2026-06-16 08:45:00', 'evt-15'),



(16, 16, 'SSE', '2026-06-17 08:00:00', NULL, 'evt-16'),



(17, 17, 'SSE', '2026-06-18 08:00:00', NULL, 'evt-17'),



(18, 18, 'SSE', '2026-06-19 08:00:00', '2026-06-19 08:45:00', 'evt-18'),



(19, 19, 'SSE', '2026-06-20 08:00:00', NULL, 'evt-19'),



(20, 20, 'SSE', '2026-06-21 08:00:00', NULL, 'evt-20'),



(21, 21, 'SSE', '2026-06-22 08:00:00', '2026-06-22 08:45:00', 'evt-21'),



(22, 22, 'SSE', '2026-06-23 08:00:00', NULL, 'evt-22'),



(23, 23, 'SSE', '2026-06-24 08:00:00', NULL, 'evt-23'),



(24, 24, 'SSE', '2026-06-25 08:00:00', '2026-06-25 08:45:00', 'evt-24'),



(25, 25, 'SSE', '2026-06-26 08:00:00', NULL, 'evt-25'),



(26, 26, 'SSE', '2026-06-27 08:00:00', NULL, 'evt-26'),



(27, 27, 'SSE', '2026-06-28 08:00:00', '2026-06-28 08:45:00', 'evt-27'),



(28, 28, 'SSE', '2026-06-01 08:00:00', NULL, 'evt-28'),



(29, 29, 'SSE', '2026-06-02 08:00:00', NULL, 'evt-29'),



(30, 30, 'SSE', '2026-06-03 08:00:00', '2026-06-03 08:45:00', 'evt-30'),



(31, 1, 'SSE', '2026-06-04 08:00:00', NULL, 'evt-31'),



(32, 2, 'SSE', '2026-06-05 08:00:00', NULL, 'evt-32'),



(33, 3, 'SSE', '2026-06-06 08:00:00', '2026-06-06 08:45:00', 'evt-33'),



(34, 4, 'SSE', '2026-06-07 08:00:00', NULL, 'evt-34'),



(35, 5, 'SSE', '2026-06-08 08:00:00', NULL, 'evt-35'),



(36, 6, 'SSE', '2026-06-09 08:00:00', '2026-06-09 08:45:00', 'evt-36'),



(37, 7, 'SSE', '2026-06-10 08:00:00', NULL, 'evt-37'),



(38, 8, 'SSE', '2026-06-11 08:00:00', NULL, 'evt-38'),



(39, 9, 'SSE', '2026-06-12 08:00:00', '2026-06-12 08:45:00', 'evt-39'),



(40, 10, 'SSE', '2026-06-13 08:00:00', NULL, 'evt-40'),



(41, 11, 'SSE', '2026-06-14 08:00:00', NULL, 'evt-41'),



(42, 12, 'SSE', '2026-06-15 08:00:00', '2026-06-15 08:45:00', 'evt-42'),



(43, 13, 'SSE', '2026-06-16 08:00:00', NULL, 'evt-43'),



(44, 14, 'SSE', '2026-06-17 08:00:00', NULL, 'evt-44'),



(45, 15, 'SSE', '2026-06-18 08:00:00', '2026-06-18 08:45:00', 'evt-45'),



(46, 16, 'SSE', '2026-06-19 08:00:00', NULL, 'evt-46'),



(47, 17, 'SSE', '2026-06-20 08:00:00', NULL, 'evt-47'),



(48, 18, 'SSE', '2026-06-21 08:00:00', '2026-06-21 08:45:00', 'evt-48'),



(49, 19, 'SSE', '2026-06-22 08:00:00', NULL, 'evt-49'),



(50, 20, 'SSE', '2026-06-23 08:00:00', NULL, 'evt-50'),



(51, 21, 'SSE', '2026-06-24 08:00:00', '2026-06-24 08:45:00', 'evt-51'),



(52, 22, 'SSE', '2026-06-25 08:00:00', NULL, 'evt-52'),



(53, 23, 'SSE', '2026-06-26 08:00:00', NULL, 'evt-53'),



(54, 24, 'SSE', '2026-06-27 08:00:00', '2026-06-27 08:45:00', 'evt-54'),



(55, 25, 'SSE', '2026-06-28 08:00:00', NULL, 'evt-55'),



(56, 26, 'SSE', '2026-06-01 08:00:00', NULL, 'evt-56'),



(57, 27, 'SSE', '2026-06-02 08:00:00', '2026-06-02 08:45:00', 'evt-57'),



(58, 28, 'SSE', '2026-06-03 08:00:00', NULL, 'evt-58'),



(59, 29, 'SSE', '2026-06-04 08:00:00', NULL, 'evt-59'),



(60, 30, 'SSE', '2026-06-05 08:00:00', '2026-06-05 08:45:00', 'evt-60');







INSERT INTO likes (id, user_id, portfolio_id) VALUES



(1, 1, 1),



(2, 2, 2),



(3, 3, 3),



(4, 4, 4),



(5, 5, 5),



(6, 6, 6),



(7, 7, 7),



(8, 8, 8),



(9, 9, 9),



(10, 10, 10),



(11, 11, 11),



(12, 12, 12),



(13, 13, 13),



(14, 14, 14),



(15, 15, 15),



(16, 16, 16),



(17, 17, 17),



(18, 18, 18),



(19, 19, 19),



(20, 20, 20),



(21, 21, 21),



(22, 22, 22),



(23, 23, 23),



(24, 24, 24),



(25, 25, 25),



(26, 26, 26),



(27, 27, 27),



(28, 28, 28),



(29, 29, 29),



(30, 30, 30),



(31, 1, 31),



(32, 2, 32),



(33, 3, 33),



(34, 4, 34),



(35, 5, 35),



(36, 6, 36),



(37, 7, 37),



(38, 8, 38),



(39, 9, 39),



(40, 10, 40),



(41, 11, 41),



(42, 12, 42),



(43, 13, 43),



(44, 14, 44),



(45, 15, 45),



(46, 16, 46),



(47, 17, 47),



(48, 18, 48),



(49, 19, 49),



(50, 20, 50),



(51, 21, 1),



(52, 22, 2),



(53, 23, 3),



(54, 24, 4),



(55, 25, 5),



(56, 26, 6),



(57, 27, 7),



(58, 28, 8),



(59, 29, 9),



(60, 30, 10),



(61, 1, 11),



(62, 2, 12),



(63, 3, 13),



(64, 4, 14),



(65, 5, 15),



(66, 6, 16),



(67, 7, 17),



(68, 8, 18),



(69, 9, 19),



(70, 10, 20),



(71, 11, 21),



(72, 12, 22),



(73, 13, 23),



(74, 14, 24),



(75, 15, 25),



(76, 16, 26),



(77, 17, 27),



(78, 18, 28),



(79, 19, 29),



(80, 20, 30);



INSERT INTO likes (id, user_id, portfolio_id) VALUES



(81, 21, 31),



(82, 22, 32),



(83, 23, 33),



(84, 24, 34),



(85, 25, 35),



(86, 26, 36),



(87, 27, 37),



(88, 28, 38),



(89, 29, 39),



(90, 30, 40),



(91, 1, 41),



(92, 2, 42),



(93, 3, 43),



(94, 4, 44),



(95, 5, 45),



(96, 6, 46),



(97, 7, 47),



(98, 8, 48),



(99, 9, 49),



(100, 10, 50),



(101, 11, 1),



(102, 12, 2),



(103, 13, 3),



(104, 14, 4),



(105, 15, 5),



(106, 16, 6),



(107, 17, 7),



(108, 18, 8),



(109, 19, 9),



(110, 20, 10),



(111, 21, 11),



(112, 22, 12),



(113, 23, 13),



(114, 24, 14),



(115, 25, 15),



(116, 26, 16),



(117, 27, 17),



(118, 28, 18),



(119, 29, 19),



(120, 30, 20);



INSERT INTO bookmarks (id, user_id, portfolio_id) VALUES



(1, 5, 1),



(2, 6, 2),



(3, 7, 3),



(4, 8, 4),



(5, 9, 5),



(6, 10, 6),



(7, 11, 7),



(8, 12, 8),



(9, 13, 9),



(10, 14, 10),



(11, 15, 11),



(12, 16, 12),



(13, 17, 13),



(14, 18, 14),



(15, 19, 15),



(16, 20, 16),



(17, 21, 17),



(18, 22, 18),



(19, 23, 19),



(20, 24, 20),



(21, 25, 21),



(22, 26, 22),



(23, 27, 23),



(24, 28, 24),



(25, 29, 25),



(26, 30, 26),



(27, 1, 27),



(28, 2, 28),



(29, 3, 29),



(30, 4, 30),



(31, 5, 31),



(32, 6, 32),



(33, 7, 33),



(34, 8, 34),



(35, 9, 35),



(36, 10, 36),



(37, 11, 37),



(38, 12, 38),



(39, 13, 39),



(40, 14, 40),



(41, 15, 41),



(42, 16, 42),



(43, 17, 43),



(44, 18, 44),



(45, 19, 45),



(46, 20, 46),



(47, 21, 47),



(48, 22, 48),



(49, 23, 49),



(50, 24, 50),



(51, 25, 1),



(52, 26, 2),



(53, 27, 3),



(54, 28, 4),



(55, 29, 5),



(56, 30, 6),



(57, 1, 7),



(58, 2, 8),



(59, 3, 9),



(60, 4, 10),



(61, 5, 11),



(62, 6, 12),



(63, 7, 13),



(64, 8, 14),



(65, 9, 15),



(66, 10, 16),



(67, 11, 17),



(68, 12, 18),



(69, 13, 19),



(70, 14, 20),



(71, 15, 21),



(72, 16, 22),



(73, 17, 23),



(74, 18, 24),



(75, 19, 25),



(76, 20, 26),



(77, 21, 27),



(78, 22, 28),



(79, 23, 29),



(80, 24, 30);



INSERT INTO bookmarks (id, user_id, portfolio_id) VALUES



(81, 25, 31),



(82, 26, 32),



(83, 27, 33),



(84, 28, 34),



(85, 29, 35),



(86, 30, 36),



(87, 1, 37),



(88, 2, 38),



(89, 3, 39),



(90, 4, 40),



(91, 5, 41),



(92, 6, 42),



(93, 7, 43),



(94, 8, 44),



(95, 9, 45),



(96, 10, 46),



(97, 11, 47),



(98, 12, 48),



(99, 13, 49),



(100, 14, 50),



(101, 15, 1),



(102, 16, 2),



(103, 17, 3),



(104, 18, 4),



(105, 19, 5),



(106, 20, 6),



(107, 21, 7),



(108, 22, 8),



(109, 23, 9),



(110, 24, 10),



(111, 25, 11),



(112, 26, 12),



(113, 27, 13),



(114, 28, 14),



(115, 29, 15),



(116, 30, 16),



(117, 1, 17),



(118, 2, 18),



(119, 3, 19),



(120, 4, 20);







INSERT INTO analytics (id, portfolio_id, stat_date, view_count, visitor_count, recruiter_count) VALUES



(1, 1, '2026-06-02', 121, 61, 6),



(2, 2, '2026-06-03', 122, 62, 7),



(3, 3, '2026-06-04', 123, 63, 8),



(4, 4, '2026-06-05', 124, 64, 9),



(5, 5, '2026-06-06', 125, 65, 10),



(6, 6, '2026-06-07', 126, 66, 11),



(7, 7, '2026-06-08', 127, 67, 5),



(8, 8, '2026-06-09', 128, 68, 6),



(9, 9, '2026-06-10', 129, 69, 7),



(10, 10, '2026-06-11', 130, 70, 8),



(11, 11, '2026-06-12', 131, 71, 9),



(12, 12, '2026-06-13', 132, 72, 10),



(13, 13, '2026-06-14', 133, 73, 11),



(14, 14, '2026-06-15', 134, 74, 5),



(15, 15, '2026-06-16', 135, 75, 6),



(16, 16, '2026-06-17', 136, 76, 7),



(17, 17, '2026-06-18', 137, 77, 8),



(18, 18, '2026-06-19', 138, 78, 9),



(19, 19, '2026-06-20', 139, 79, 10),



(20, 20, '2026-06-21', 140, 80, 11),



(21, 21, '2026-06-22', 141, 81, 5),



(22, 22, '2026-06-23', 142, 82, 6),



(23, 23, '2026-06-24', 143, 83, 7),



(24, 24, '2026-06-25', 144, 84, 8),



(25, 25, '2026-06-26', 145, 85, 9),



(26, 26, '2026-06-27', 146, 86, 10),



(27, 27, '2026-06-28', 147, 87, 11),



(28, 28, '2026-06-01', 148, 88, 5),



(29, 29, '2026-06-02', 149, 89, 6),



(30, 30, '2026-06-03', 150, 90, 7),



(31, 31, '2026-06-04', 151, 91, 8),



(32, 32, '2026-06-05', 152, 92, 9),



(33, 33, '2026-06-06', 153, 93, 10),



(34, 34, '2026-06-07', 154, 94, 11),



(35, 35, '2026-06-08', 155, 95, 5),



(36, 36, '2026-06-09', 156, 96, 6),



(37, 37, '2026-06-10', 157, 97, 7),



(38, 38, '2026-06-11', 158, 98, 8),



(39, 39, '2026-06-12', 159, 99, 9),



(40, 40, '2026-06-13', 160, 100, 10),



(41, 41, '2026-06-14', 161, 101, 11),



(42, 42, '2026-06-15', 162, 102, 5),



(43, 43, '2026-06-16', 163, 103, 6),



(44, 44, '2026-06-17', 164, 104, 7),



(45, 45, '2026-06-18', 165, 60, 8),



(46, 46, '2026-06-19', 166, 61, 9),



(47, 47, '2026-06-20', 167, 62, 10),



(48, 48, '2026-06-21', 168, 63, 11),



(49, 49, '2026-06-22', 169, 64, 5),



(50, 50, '2026-06-23', 170, 65, 6);



INSERT INTO analytics (id, portfolio_id, stat_date, view_count, visitor_count, recruiter_count) VALUES



(51, 1, '2026-06-24', 171, 66, 7),



(52, 2, '2026-06-25', 172, 67, 8),



(53, 3, '2026-06-26', 173, 68, 9),



(54, 4, '2026-06-27', 174, 69, 10),



(55, 5, '2026-06-28', 175, 70, 11),



(56, 6, '2026-06-01', 176, 71, 5),



(57, 7, '2026-06-02', 177, 72, 6),



(58, 8, '2026-06-03', 178, 73, 7),



(59, 9, '2026-06-04', 179, 74, 8),



(60, 10, '2026-06-05', 180, 75, 9),



(61, 11, '2026-06-06', 181, 76, 10),



(62, 12, '2026-06-07', 182, 77, 11),



(63, 13, '2026-06-08', 183, 78, 5),



(64, 14, '2026-06-09', 184, 79, 6),



(65, 15, '2026-06-10', 185, 80, 7),



(66, 16, '2026-06-11', 186, 81, 8),



(67, 17, '2026-06-12', 187, 82, 9),



(68, 18, '2026-06-13', 188, 83, 10),



(69, 19, '2026-06-14', 189, 84, 11),



(70, 20, '2026-06-15', 190, 85, 5),



(71, 21, '2026-06-16', 191, 86, 6),



(72, 22, '2026-06-17', 192, 87, 7),



(73, 23, '2026-06-18', 193, 88, 8),



(74, 24, '2026-06-19', 194, 89, 9),



(75, 25, '2026-06-20', 195, 90, 10),



(76, 26, '2026-06-21', 196, 91, 11),



(77, 27, '2026-06-22', 197, 92, 5),



(78, 28, '2026-06-23', 198, 93, 6),



(79, 29, '2026-06-24', 199, 94, 7),



(80, 30, '2026-06-25', 200, 95, 8),



(81, 31, '2026-06-26', 201, 96, 9),



(82, 32, '2026-06-27', 202, 97, 10),



(83, 33, '2026-06-28', 203, 98, 11),



(84, 34, '2026-06-01', 204, 99, 5),



(85, 35, '2026-06-02', 205, 100, 6),



(86, 36, '2026-06-03', 206, 101, 7),



(87, 37, '2026-06-04', 207, 102, 8),



(88, 38, '2026-06-05', 208, 103, 9),



(89, 39, '2026-06-06', 209, 104, 10),



(90, 40, '2026-06-07', 210, 60, 11),



(91, 41, '2026-06-08', 211, 61, 5),



(92, 42, '2026-06-09', 212, 62, 6),



(93, 43, '2026-06-10', 213, 63, 7),



(94, 44, '2026-06-11', 214, 64, 8),



(95, 45, '2026-06-12', 215, 65, 9),



(96, 46, '2026-06-13', 216, 66, 10),



(97, 47, '2026-06-14', 217, 67, 11),



(98, 48, '2026-06-15', 218, 68, 5),



(99, 49, '2026-06-16', 219, 69, 6),



(100, 50, '2026-06-17', 220, 70, 7);



INSERT INTO analytics (id, portfolio_id, stat_date, view_count, visitor_count, recruiter_count) VALUES



(101, 1, '2026-06-18', 221, 71, 8),



(102, 2, '2026-06-19', 222, 72, 9),



(103, 3, '2026-06-20', 223, 73, 10),



(104, 4, '2026-06-21', 224, 74, 11),



(105, 5, '2026-06-22', 225, 75, 5),



(106, 6, '2026-06-23', 226, 76, 6),



(107, 7, '2026-06-24', 227, 77, 7),



(108, 8, '2026-06-25', 228, 78, 8),



(109, 9, '2026-06-26', 229, 79, 9),



(110, 10, '2026-06-27', 230, 80, 10),



(111, 11, '2026-06-28', 231, 81, 11),



(112, 12, '2026-06-01', 232, 82, 5),



(113, 13, '2026-06-02', 233, 83, 6),



(114, 14, '2026-06-03', 234, 84, 7),



(115, 15, '2026-06-04', 235, 85, 8),



(116, 16, '2026-06-05', 236, 86, 9),



(117, 17, '2026-06-06', 237, 87, 10),



(118, 18, '2026-06-07', 238, 88, 11),



(119, 19, '2026-06-08', 239, 89, 5),



(120, 20, '2026-06-09', 240, 90, 6),



(121, 21, '2026-06-10', 241, 91, 7),



(122, 22, '2026-06-11', 242, 92, 8),



(123, 23, '2026-06-12', 243, 93, 9),



(124, 24, '2026-06-13', 244, 94, 10),



(125, 25, '2026-06-14', 245, 95, 11),



(126, 26, '2026-06-15', 246, 96, 5),



(127, 27, '2026-06-16', 247, 97, 6),



(128, 28, '2026-06-17', 248, 98, 7),



(129, 29, '2026-06-18', 249, 99, 8),



(130, 30, '2026-06-19', 250, 100, 9),



(131, 31, '2026-06-20', 251, 101, 10),



(132, 32, '2026-06-21', 252, 102, 11),



(133, 33, '2026-06-22', 253, 103, 5),



(134, 34, '2026-06-23', 254, 104, 6),



(135, 35, '2026-06-24', 255, 60, 7),



(136, 36, '2026-06-25', 256, 61, 8),



(137, 37, '2026-06-26', 257, 62, 9),



(138, 38, '2026-06-27', 258, 63, 10),



(139, 39, '2026-06-28', 259, 64, 11),



(140, 40, '2026-06-01', 260, 65, 5),



(141, 41, '2026-06-02', 261, 66, 6),



(142, 42, '2026-06-03', 262, 67, 7),



(143, 43, '2026-06-04', 263, 68, 8),



(144, 44, '2026-06-05', 264, 69, 9),



(145, 45, '2026-06-06', 265, 70, 10),



(146, 46, '2026-06-07', 266, 71, 11),



(147, 47, '2026-06-08', 267, 72, 5),



(148, 48, '2026-06-09', 268, 73, 6),



(149, 49, '2026-06-10', 269, 74, 7),



(150, 50, '2026-06-11', 270, 75, 8);



INSERT INTO analytics_referrers (id, stat_id, source, visit_count) VALUES



(1, 1, 'DIRECT', 22),



(2, 1, 'GITHUB', 23),



(3, 1, 'FIGMA', 24),



(4, 2, 'DIRECT', 23),



(5, 2, 'GITHUB', 24),



(6, 2, 'FIGMA', 25),



(7, 3, 'DIRECT', 24),



(8, 3, 'GITHUB', 25),



(9, 3, 'FIGMA', 26),



(10, 4, 'DIRECT', 25),



(11, 4, 'GITHUB', 26),



(12, 4, 'FIGMA', 27),



(13, 5, 'DIRECT', 26),



(14, 5, 'GITHUB', 27),



(15, 5, 'FIGMA', 28),



(16, 6, 'DIRECT', 27),



(17, 6, 'GITHUB', 28),



(18, 6, 'FIGMA', 29),



(19, 7, 'DIRECT', 28),



(20, 7, 'GITHUB', 29),



(21, 7, 'FIGMA', 30),



(22, 8, 'DIRECT', 29),



(23, 8, 'GITHUB', 30),



(24, 8, 'FIGMA', 20),



(25, 9, 'DIRECT', 30),



(26, 9, 'GITHUB', 20),



(27, 9, 'FIGMA', 21),



(28, 10, 'DIRECT', 20),



(29, 10, 'GITHUB', 21),



(30, 10, 'FIGMA', 22),



(31, 11, 'DIRECT', 21),



(32, 11, 'GITHUB', 22),



(33, 11, 'FIGMA', 23),



(34, 12, 'DIRECT', 22),



(35, 12, 'GITHUB', 23),



(36, 12, 'FIGMA', 24),



(37, 13, 'DIRECT', 23),



(38, 13, 'GITHUB', 24),



(39, 13, 'FIGMA', 25),



(40, 14, 'DIRECT', 24),



(41, 14, 'GITHUB', 25),



(42, 14, 'FIGMA', 26),



(43, 15, 'DIRECT', 25),



(44, 15, 'GITHUB', 26),



(45, 15, 'FIGMA', 27),



(46, 16, 'DIRECT', 26),



(47, 16, 'GITHUB', 27),



(48, 16, 'FIGMA', 28),



(49, 17, 'DIRECT', 27),



(50, 17, 'GITHUB', 28),



(51, 17, 'FIGMA', 29),



(52, 18, 'DIRECT', 28),



(53, 18, 'GITHUB', 29),



(54, 18, 'FIGMA', 30),



(55, 19, 'DIRECT', 29),



(56, 19, 'GITHUB', 30),



(57, 19, 'FIGMA', 20),



(58, 20, 'DIRECT', 30),



(59, 20, 'GITHUB', 20),



(60, 20, 'FIGMA', 21),



(61, 21, 'DIRECT', 20),



(62, 21, 'GITHUB', 21),



(63, 21, 'FIGMA', 22),



(64, 22, 'DIRECT', 21),



(65, 22, 'GITHUB', 22),



(66, 22, 'FIGMA', 23),



(67, 23, 'DIRECT', 22),



(68, 23, 'GITHUB', 23),



(69, 23, 'FIGMA', 24),



(70, 24, 'DIRECT', 23),



(71, 24, 'GITHUB', 24),



(72, 24, 'FIGMA', 25),



(73, 25, 'DIRECT', 24),



(74, 25, 'GITHUB', 25),



(75, 25, 'FIGMA', 26),



(76, 26, 'DIRECT', 25),



(77, 26, 'GITHUB', 26),



(78, 26, 'FIGMA', 27),



(79, 27, 'DIRECT', 26),



(80, 27, 'GITHUB', 27),



(81, 27, 'FIGMA', 28),



(82, 28, 'DIRECT', 27),



(83, 28, 'GITHUB', 28),



(84, 28, 'FIGMA', 29),



(85, 29, 'DIRECT', 28),



(86, 29, 'GITHUB', 29),



(87, 29, 'FIGMA', 30),



(88, 30, 'DIRECT', 29),



(89, 30, 'GITHUB', 30),



(90, 30, 'FIGMA', 20),



(91, 31, 'DIRECT', 30),



(92, 31, 'GITHUB', 20),



(93, 31, 'FIGMA', 21),



(94, 32, 'DIRECT', 20),



(95, 32, 'GITHUB', 21),



(96, 32, 'FIGMA', 22),



(97, 33, 'DIRECT', 21),



(98, 33, 'GITHUB', 22),



(99, 33, 'FIGMA', 23),



(100, 34, 'DIRECT', 22);



INSERT INTO analytics_referrers (id, stat_id, source, visit_count) VALUES



(101, 34, 'GITHUB', 23),



(102, 34, 'FIGMA', 24),



(103, 35, 'DIRECT', 23),



(104, 35, 'GITHUB', 24),



(105, 35, 'FIGMA', 25),



(106, 36, 'DIRECT', 24),



(107, 36, 'GITHUB', 25),



(108, 36, 'FIGMA', 26),



(109, 37, 'DIRECT', 25),



(110, 37, 'GITHUB', 26),



(111, 37, 'FIGMA', 27),



(112, 38, 'DIRECT', 26),



(113, 38, 'GITHUB', 27),



(114, 38, 'FIGMA', 28),



(115, 39, 'DIRECT', 27),



(116, 39, 'GITHUB', 28),



(117, 39, 'FIGMA', 29),



(118, 40, 'DIRECT', 28),



(119, 40, 'GITHUB', 29),



(120, 40, 'FIGMA', 30),



(121, 41, 'DIRECT', 29),



(122, 41, 'GITHUB', 30),



(123, 41, 'FIGMA', 20),



(124, 42, 'DIRECT', 30),



(125, 42, 'GITHUB', 20),



(126, 42, 'FIGMA', 21),



(127, 43, 'DIRECT', 20),



(128, 43, 'GITHUB', 21),



(129, 43, 'FIGMA', 22),



(130, 44, 'DIRECT', 21),



(131, 44, 'GITHUB', 22),



(132, 44, 'FIGMA', 23),



(133, 45, 'DIRECT', 22),



(134, 45, 'GITHUB', 23),



(135, 45, 'FIGMA', 24),



(136, 46, 'DIRECT', 23),



(137, 46, 'GITHUB', 24),



(138, 46, 'FIGMA', 25),



(139, 47, 'DIRECT', 24),



(140, 47, 'GITHUB', 25),



(141, 47, 'FIGMA', 26),



(142, 48, 'DIRECT', 25),



(143, 48, 'GITHUB', 26),



(144, 48, 'FIGMA', 27),



(145, 49, 'DIRECT', 26),



(146, 49, 'GITHUB', 27),



(147, 49, 'FIGMA', 28),



(148, 50, 'DIRECT', 27),



(149, 50, 'GITHUB', 28),



(150, 50, 'FIGMA', 29),



(151, 51, 'DIRECT', 28),



(152, 51, 'GITHUB', 29),



(153, 51, 'FIGMA', 30),



(154, 52, 'DIRECT', 29),



(155, 52, 'GITHUB', 30),



(156, 52, 'FIGMA', 20),



(157, 53, 'DIRECT', 30),



(158, 53, 'GITHUB', 20),



(159, 53, 'FIGMA', 21),



(160, 54, 'DIRECT', 20),



(161, 54, 'GITHUB', 21),



(162, 54, 'FIGMA', 22),



(163, 55, 'DIRECT', 21),



(164, 55, 'GITHUB', 22),



(165, 55, 'FIGMA', 23),



(166, 56, 'DIRECT', 22),



(167, 56, 'GITHUB', 23),



(168, 56, 'FIGMA', 24),



(169, 57, 'DIRECT', 23),



(170, 57, 'GITHUB', 24),



(171, 57, 'FIGMA', 25),



(172, 58, 'DIRECT', 24),



(173, 58, 'GITHUB', 25),



(174, 58, 'FIGMA', 26),



(175, 59, 'DIRECT', 25),



(176, 59, 'GITHUB', 26),



(177, 59, 'FIGMA', 27),



(178, 60, 'DIRECT', 26),



(179, 60, 'GITHUB', 27),



(180, 60, 'FIGMA', 28),



(181, 61, 'DIRECT', 27),



(182, 61, 'GITHUB', 28),



(183, 61, 'FIGMA', 29),



(184, 62, 'DIRECT', 28),



(185, 62, 'GITHUB', 29),



(186, 62, 'FIGMA', 30),



(187, 63, 'DIRECT', 29),



(188, 63, 'GITHUB', 30),



(189, 63, 'FIGMA', 20),



(190, 64, 'DIRECT', 30),



(191, 64, 'GITHUB', 20),



(192, 64, 'FIGMA', 21),



(193, 65, 'DIRECT', 20),



(194, 65, 'GITHUB', 21),



(195, 65, 'FIGMA', 22),



(196, 66, 'DIRECT', 21),



(197, 66, 'GITHUB', 22),



(198, 66, 'FIGMA', 23),



(199, 67, 'DIRECT', 22),



(200, 67, 'GITHUB', 23);



INSERT INTO analytics_referrers (id, stat_id, source, visit_count) VALUES



(201, 67, 'FIGMA', 24),



(202, 68, 'DIRECT', 23),



(203, 68, 'GITHUB', 24),



(204, 68, 'FIGMA', 25),



(205, 69, 'DIRECT', 24),



(206, 69, 'GITHUB', 25),



(207, 69, 'FIGMA', 26),



(208, 70, 'DIRECT', 25),



(209, 70, 'GITHUB', 26),



(210, 70, 'FIGMA', 27),



(211, 71, 'DIRECT', 26),



(212, 71, 'GITHUB', 27),



(213, 71, 'FIGMA', 28),



(214, 72, 'DIRECT', 27),



(215, 72, 'GITHUB', 28),



(216, 72, 'FIGMA', 29),



(217, 73, 'DIRECT', 28),



(218, 73, 'GITHUB', 29),



(219, 73, 'FIGMA', 30),



(220, 74, 'DIRECT', 29),



(221, 74, 'GITHUB', 30),



(222, 74, 'FIGMA', 20),



(223, 75, 'DIRECT', 30),



(224, 75, 'GITHUB', 20),



(225, 75, 'FIGMA', 21),



(226, 76, 'DIRECT', 20),



(227, 76, 'GITHUB', 21),



(228, 76, 'FIGMA', 22),



(229, 77, 'DIRECT', 21),



(230, 77, 'GITHUB', 22),



(231, 77, 'FIGMA', 23),



(232, 78, 'DIRECT', 22),



(233, 78, 'GITHUB', 23),



(234, 78, 'FIGMA', 24),



(235, 79, 'DIRECT', 23),



(236, 79, 'GITHUB', 24),



(237, 79, 'FIGMA', 25),



(238, 80, 'DIRECT', 24),



(239, 80, 'GITHUB', 25),



(240, 80, 'FIGMA', 26),



(241, 81, 'DIRECT', 25),



(242, 81, 'GITHUB', 26),



(243, 81, 'FIGMA', 27),



(244, 82, 'DIRECT', 26),



(245, 82, 'GITHUB', 27),



(246, 82, 'FIGMA', 28),



(247, 83, 'DIRECT', 27),



(248, 83, 'GITHUB', 28),



(249, 83, 'FIGMA', 29),



(250, 84, 'DIRECT', 28),



(251, 84, 'GITHUB', 29),



(252, 84, 'FIGMA', 30),



(253, 85, 'DIRECT', 29),



(254, 85, 'GITHUB', 30),



(255, 85, 'FIGMA', 20),



(256, 86, 'DIRECT', 30),



(257, 86, 'GITHUB', 20),



(258, 86, 'FIGMA', 21),



(259, 87, 'DIRECT', 20),



(260, 87, 'GITHUB', 21),



(261, 87, 'FIGMA', 22),



(262, 88, 'DIRECT', 21),



(263, 88, 'GITHUB', 22),



(264, 88, 'FIGMA', 23),



(265, 89, 'DIRECT', 22),



(266, 89, 'GITHUB', 23),



(267, 89, 'FIGMA', 24),



(268, 90, 'DIRECT', 23),



(269, 90, 'GITHUB', 24),



(270, 90, 'FIGMA', 25),



(271, 91, 'DIRECT', 24),



(272, 91, 'GITHUB', 25),



(273, 91, 'FIGMA', 26),



(274, 92, 'DIRECT', 25),



(275, 92, 'GITHUB', 26),



(276, 92, 'FIGMA', 27),



(277, 93, 'DIRECT', 26),



(278, 93, 'GITHUB', 27),



(279, 93, 'FIGMA', 28),



(280, 94, 'DIRECT', 27),



(281, 94, 'GITHUB', 28),



(282, 94, 'FIGMA', 29),



(283, 95, 'DIRECT', 28),



(284, 95, 'GITHUB', 29),



(285, 95, 'FIGMA', 30),



(286, 96, 'DIRECT', 29),



(287, 96, 'GITHUB', 30),



(288, 96, 'FIGMA', 20),



(289, 97, 'DIRECT', 30),



(290, 97, 'GITHUB', 20),



(291, 97, 'FIGMA', 21),



(292, 98, 'DIRECT', 20),



(293, 98, 'GITHUB', 21),



(294, 98, 'FIGMA', 22),



(295, 99, 'DIRECT', 21),



(296, 99, 'GITHUB', 22),



(297, 99, 'FIGMA', 23),



(298, 100, 'DIRECT', 22),



(299, 100, 'GITHUB', 23),



(300, 100, 'FIGMA', 24);



INSERT INTO analytics_referrers (id, stat_id, source, visit_count) VALUES



(301, 101, 'DIRECT', 23),



(302, 101, 'GITHUB', 24),



(303, 101, 'FIGMA', 25),



(304, 102, 'DIRECT', 24),



(305, 102, 'GITHUB', 25),



(306, 102, 'FIGMA', 26),



(307, 103, 'DIRECT', 25),



(308, 103, 'GITHUB', 26),



(309, 103, 'FIGMA', 27),



(310, 104, 'DIRECT', 26),



(311, 104, 'GITHUB', 27),



(312, 104, 'FIGMA', 28),



(313, 105, 'DIRECT', 27),



(314, 105, 'GITHUB', 28),



(315, 105, 'FIGMA', 29),



(316, 106, 'DIRECT', 28),



(317, 106, 'GITHUB', 29),



(318, 106, 'FIGMA', 30),



(319, 107, 'DIRECT', 29),



(320, 107, 'GITHUB', 30),



(321, 107, 'FIGMA', 20),



(322, 108, 'DIRECT', 30),



(323, 108, 'GITHUB', 20),



(324, 108, 'FIGMA', 21),



(325, 109, 'DIRECT', 20),



(326, 109, 'GITHUB', 21),



(327, 109, 'FIGMA', 22),



(328, 110, 'DIRECT', 21),



(329, 110, 'GITHUB', 22),



(330, 110, 'FIGMA', 23),



(331, 111, 'DIRECT', 22),



(332, 111, 'GITHUB', 23),



(333, 111, 'FIGMA', 24),



(334, 112, 'DIRECT', 23),



(335, 112, 'GITHUB', 24),



(336, 112, 'FIGMA', 25),



(337, 113, 'DIRECT', 24),



(338, 113, 'GITHUB', 25),



(339, 113, 'FIGMA', 26),



(340, 114, 'DIRECT', 25),



(341, 114, 'GITHUB', 26),



(342, 114, 'FIGMA', 27),



(343, 115, 'DIRECT', 26),



(344, 115, 'GITHUB', 27),



(345, 115, 'FIGMA', 28),



(346, 116, 'DIRECT', 27),



(347, 116, 'GITHUB', 28),



(348, 116, 'FIGMA', 29),



(349, 117, 'DIRECT', 28),



(350, 117, 'GITHUB', 29),



(351, 117, 'FIGMA', 30),



(352, 118, 'DIRECT', 29),



(353, 118, 'GITHUB', 30),



(354, 118, 'FIGMA', 20),



(355, 119, 'DIRECT', 30),



(356, 119, 'GITHUB', 20),



(357, 119, 'FIGMA', 21),



(358, 120, 'DIRECT', 20),



(359, 120, 'GITHUB', 21),



(360, 120, 'FIGMA', 22),



(361, 121, 'DIRECT', 21),



(362, 121, 'GITHUB', 22),



(363, 121, 'FIGMA', 23),



(364, 122, 'DIRECT', 22),



(365, 122, 'GITHUB', 23),



(366, 122, 'FIGMA', 24),



(367, 123, 'DIRECT', 23),



(368, 123, 'GITHUB', 24),



(369, 123, 'FIGMA', 25),



(370, 124, 'DIRECT', 24),



(371, 124, 'GITHUB', 25),



(372, 124, 'FIGMA', 26),



(373, 125, 'DIRECT', 25),



(374, 125, 'GITHUB', 26),



(375, 125, 'FIGMA', 27),



(376, 126, 'DIRECT', 26),



(377, 126, 'GITHUB', 27),



(378, 126, 'FIGMA', 28),



(379, 127, 'DIRECT', 27),



(380, 127, 'GITHUB', 28),



(381, 127, 'FIGMA', 29),



(382, 128, 'DIRECT', 28),



(383, 128, 'GITHUB', 29),



(384, 128, 'FIGMA', 30),



(385, 129, 'DIRECT', 29),



(386, 129, 'GITHUB', 30),



(387, 129, 'FIGMA', 20),



(388, 130, 'DIRECT', 30),



(389, 130, 'GITHUB', 20),



(390, 130, 'FIGMA', 21),



(391, 131, 'DIRECT', 20),



(392, 131, 'GITHUB', 21),



(393, 131, 'FIGMA', 22),



(394, 132, 'DIRECT', 21),



(395, 132, 'GITHUB', 22),



(396, 132, 'FIGMA', 23),



(397, 133, 'DIRECT', 22),



(398, 133, 'GITHUB', 23),



(399, 133, 'FIGMA', 24),



(400, 134, 'DIRECT', 23);



INSERT INTO analytics_referrers (id, stat_id, source, visit_count) VALUES



(401, 134, 'GITHUB', 24),



(402, 134, 'FIGMA', 25),



(403, 135, 'DIRECT', 24),



(404, 135, 'GITHUB', 25),



(405, 135, 'FIGMA', 26),



(406, 136, 'DIRECT', 25),



(407, 136, 'GITHUB', 26),



(408, 136, 'FIGMA', 27),



(409, 137, 'DIRECT', 26),



(410, 137, 'GITHUB', 27),



(411, 137, 'FIGMA', 28),



(412, 138, 'DIRECT', 27),



(413, 138, 'GITHUB', 28),



(414, 138, 'FIGMA', 29),



(415, 139, 'DIRECT', 28),



(416, 139, 'GITHUB', 29),



(417, 139, 'FIGMA', 30),



(418, 140, 'DIRECT', 29),



(419, 140, 'GITHUB', 30),



(420, 140, 'FIGMA', 20),



(421, 141, 'DIRECT', 30),



(422, 141, 'GITHUB', 20),



(423, 141, 'FIGMA', 21),



(424, 142, 'DIRECT', 20),



(425, 142, 'GITHUB', 21),



(426, 142, 'FIGMA', 22),



(427, 143, 'DIRECT', 21),



(428, 143, 'GITHUB', 22),



(429, 143, 'FIGMA', 23),



(430, 144, 'DIRECT', 22),



(431, 144, 'GITHUB', 23),



(432, 144, 'FIGMA', 24),



(433, 145, 'DIRECT', 23),



(434, 145, 'GITHUB', 24),



(435, 145, 'FIGMA', 25),



(436, 146, 'DIRECT', 24),



(437, 146, 'GITHUB', 25),



(438, 146, 'FIGMA', 26),



(439, 147, 'DIRECT', 25),



(440, 147, 'GITHUB', 26),



(441, 147, 'FIGMA', 27),



(442, 148, 'DIRECT', 26),



(443, 148, 'GITHUB', 27),



(444, 148, 'FIGMA', 28),



(445, 149, 'DIRECT', 27),



(446, 149, 'GITHUB', 28),



(447, 149, 'FIGMA', 29),



(448, 150, 'DIRECT', 28),



(449, 150, 'GITHUB', 29),



(450, 150, 'FIGMA', 30);







INSERT INTO comments (id, document_id, user_id, parent_comment_id, content) VALUES



(1, 1, 6, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(2, 2, 7, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(3, 3, 8, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(4, 4, 9, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(5, 5, 10, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(6, 6, 11, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(7, 7, 12, 2, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(8, 8, 13, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(9, 9, 14, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(10, 10, 15, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(11, 11, 16, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(12, 12, 17, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(13, 13, 18, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(14, 14, 19, 9, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(15, 15, 20, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(16, 16, 21, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(17, 17, 22, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(18, 18, 23, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(19, 19, 24, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(20, 20, 25, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(21, 21, 26, 16, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(22, 22, 27, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(23, 23, 28, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(24, 24, 29, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(25, 25, 30, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(26, 26, 1, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(27, 27, 2, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(28, 28, 3, 23, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(29, 29, 4, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(30, 30, 5, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(31, 31, 6, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(32, 32, 7, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(33, 33, 8, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(34, 34, 9, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(35, 35, 10, 30, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(36, 36, 11, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(37, 37, 12, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(38, 38, 13, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(39, 39, 14, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(40, 40, 15, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(41, 41, 16, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(42, 42, 17, 37, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(43, 43, 18, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(44, 44, 19, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(45, 45, 20, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(46, 46, 21, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(47, 47, 22, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(48, 48, 23, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(49, 49, 24, 44, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(50, 50, 25, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(51, 51, 26, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(52, 52, 27, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(53, 53, 28, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(54, 54, 29, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(55, 55, 30, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(56, 56, 1, 51, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(57, 57, 2, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(58, 58, 3, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(59, 59, 4, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(60, 60, 5, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(61, 61, 6, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(62, 62, 7, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(63, 63, 8, 58, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(64, 64, 9, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(65, 65, 10, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(66, 66, 11, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(67, 67, 12, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(68, 68, 13, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(69, 69, 14, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(70, 70, 15, 65, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(71, 71, 16, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(72, 72, 17, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(73, 73, 18, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(74, 74, 19, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(75, 75, 20, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(76, 76, 21, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(77, 77, 22, 72, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(78, 78, 23, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(79, 79, 24, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(80, 80, 25, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(81, 81, 26, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(82, 82, 27, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(83, 83, 28, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(84, 84, 29, 79, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(85, 85, 30, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(86, 86, 1, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(87, 87, 2, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(88, 88, 3, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(89, 89, 4, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(90, 90, 5, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(91, 91, 6, 86, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(92, 92, 7, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(93, 93, 8, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(94, 94, 9, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(95, 95, 10, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(96, 96, 11, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(97, 97, 12, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(98, 98, 13, 93, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(99, 99, 14, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(100, 100, 15, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.');



INSERT INTO comments (id, document_id, user_id, parent_comment_id, content) VALUES



(101, 101, 16, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(102, 102, 17, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(103, 103, 18, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(104, 104, 19, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(105, 105, 20, 100, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(106, 106, 21, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(107, 107, 22, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(108, 108, 23, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(109, 109, 24, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(110, 110, 25, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(111, 111, 26, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(112, 112, 27, 107, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(113, 113, 28, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(114, 114, 29, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(115, 115, 30, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(116, 116, 1, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(117, 117, 2, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(118, 118, 3, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(119, 119, 4, 114, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(120, 120, 5, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(121, 1, 6, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(122, 2, 7, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(123, 3, 8, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(124, 4, 9, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(125, 5, 10, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(126, 6, 11, 121, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(127, 7, 12, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(128, 8, 13, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(129, 9, 14, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(130, 10, 15, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(131, 11, 16, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(132, 12, 17, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(133, 13, 18, 128, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(134, 14, 19, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(135, 15, 20, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(136, 16, 21, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(137, 17, 22, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(138, 18, 23, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(139, 19, 24, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(140, 20, 25, 135, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(141, 21, 26, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(142, 22, 27, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(143, 23, 28, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(144, 24, 29, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(145, 25, 30, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(146, 26, 1, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(147, 27, 2, 142, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(148, 28, 3, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(149, 29, 4, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(150, 30, 5, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(151, 31, 6, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(152, 32, 7, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(153, 33, 8, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(154, 34, 9, 149, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(155, 35, 10, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(156, 36, 11, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(157, 37, 12, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(158, 38, 13, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(159, 39, 14, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(160, 40, 15, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(161, 41, 16, 156, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(162, 42, 17, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(163, 43, 18, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(164, 44, 19, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(165, 45, 20, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(166, 46, 21, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(167, 47, 22, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(168, 48, 23, 163, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(169, 49, 24, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(170, 50, 25, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(171, 51, 26, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(172, 52, 27, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(173, 53, 28, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(174, 54, 29, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(175, 55, 30, 170, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(176, 56, 1, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(177, 57, 2, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(178, 58, 3, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(179, 59, 4, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(180, 60, 5, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(181, 61, 6, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(182, 62, 7, 177, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(183, 63, 8, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(184, 64, 9, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(185, 65, 10, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(186, 66, 11, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(187, 67, 12, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(188, 68, 13, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(189, 69, 14, 184, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(190, 70, 15, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(191, 71, 16, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(192, 72, 17, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(193, 73, 18, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(194, 74, 19, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(195, 75, 20, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(196, 76, 21, 191, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(197, 77, 22, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(198, 78, 23, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(199, 79, 24, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(200, 80, 25, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.');



INSERT INTO comments (id, document_id, user_id, parent_comment_id, content) VALUES



(201, 81, 26, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(202, 82, 27, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(203, 83, 28, 198, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(204, 84, 29, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(205, 85, 30, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(206, 86, 1, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(207, 87, 2, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(208, 88, 3, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(209, 89, 4, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(210, 90, 5, 205, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(211, 91, 6, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(212, 92, 7, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(213, 93, 8, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(214, 94, 9, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(215, 95, 10, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(216, 96, 11, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(217, 97, 12, 212, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(218, 98, 13, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(219, 99, 14, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(220, 100, 15, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(221, 101, 16, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(222, 102, 17, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(223, 103, 18, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(224, 104, 19, 219, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(225, 105, 20, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(226, 106, 21, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(227, 107, 22, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(228, 108, 23, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(229, 109, 24, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(230, 110, 25, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(231, 111, 26, 226, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(232, 112, 27, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(233, 113, 28, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(234, 114, 29, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(235, 115, 30, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(236, 116, 1, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(237, 117, 2, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(238, 118, 3, 233, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(239, 119, 4, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(240, 120, 5, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(241, 1, 6, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(242, 2, 7, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(243, 3, 8, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(244, 4, 9, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(245, 5, 10, 240, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(246, 6, 11, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(247, 7, 12, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(248, 8, 13, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(249, 9, 14, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(250, 10, 15, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(251, 11, 16, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(252, 12, 17, 247, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(253, 13, 18, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(254, 14, 19, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(255, 15, 20, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(256, 16, 21, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(257, 17, 22, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(258, 18, 23, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(259, 19, 24, 254, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(260, 20, 25, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(261, 21, 26, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(262, 22, 27, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(263, 23, 28, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(264, 24, 29, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(265, 25, 30, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(266, 26, 1, 261, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(267, 27, 2, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(268, 28, 3, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(269, 29, 4, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(270, 30, 5, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(271, 31, 6, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(272, 32, 7, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(273, 33, 8, 268, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(274, 34, 9, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(275, 35, 10, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(276, 36, 11, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(277, 37, 12, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(278, 38, 13, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(279, 39, 14, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(280, 40, 15, 275, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(281, 41, 16, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(282, 42, 17, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(283, 43, 18, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(284, 44, 19, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(285, 45, 20, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(286, 46, 21, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(287, 47, 22, 282, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(288, 48, 23, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(289, 49, 24, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(290, 50, 25, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(291, 51, 26, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(292, 52, 27, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(293, 53, 28, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(294, 54, 29, 289, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(295, 55, 30, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(296, 56, 1, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(297, 57, 2, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(298, 58, 3, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(299, 59, 4, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(300, 60, 5, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.');



INSERT INTO comments (id, document_id, user_id, parent_comment_id, content) VALUES



(301, 61, 6, 296, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(302, 62, 7, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(303, 63, 8, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(304, 64, 9, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(305, 65, 10, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(306, 66, 11, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(307, 67, 12, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(308, 68, 13, 303, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(309, 69, 14, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(310, 70, 15, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(311, 71, 16, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(312, 72, 17, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(313, 73, 18, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(314, 74, 19, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(315, 75, 20, 310, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(316, 76, 21, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(317, 77, 22, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(318, 78, 23, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(319, 79, 24, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(320, 80, 25, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(321, 81, 26, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(322, 82, 27, 317, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(323, 83, 28, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(324, 84, 29, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(325, 85, 30, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(326, 86, 1, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(327, 87, 2, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(328, 88, 3, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(329, 89, 4, 324, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(330, 90, 5, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(331, 91, 6, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(332, 92, 7, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(333, 93, 8, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(334, 94, 9, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(335, 95, 10, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(336, 96, 11, 331, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(337, 97, 12, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(338, 98, 13, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(339, 99, 14, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(340, 100, 15, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(341, 101, 16, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(342, 102, 17, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(343, 103, 18, 338, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(344, 104, 19, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(345, 105, 20, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(346, 106, 21, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(347, 107, 22, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(348, 108, 23, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(349, 109, 24, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(350, 110, 25, 345, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(351, 111, 26, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(352, 112, 27, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(353, 113, 28, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(354, 114, 29, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(355, 115, 30, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(356, 116, 1, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(357, 117, 2, 352, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(358, 118, 3, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(359, 119, 4, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(360, 120, 5, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(361, 1, 6, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(362, 2, 7, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(363, 3, 8, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(364, 4, 9, 359, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(365, 5, 10, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(366, 6, 11, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(367, 7, 12, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(368, 8, 13, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(369, 9, 14, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(370, 10, 15, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(371, 11, 16, 366, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(372, 12, 17, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(373, 13, 18, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(374, 14, 19, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(375, 15, 20, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(376, 16, 21, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(377, 17, 22, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(378, 18, 23, 373, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(379, 19, 24, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(380, 20, 25, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(381, 21, 26, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(382, 22, 27, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(383, 23, 28, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(384, 24, 29, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(385, 25, 30, 380, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(386, 26, 1, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(387, 27, 2, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(388, 28, 3, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(389, 29, 4, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(390, 30, 5, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(391, 31, 6, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(392, 32, 7, 387, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(393, 33, 8, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(394, 34, 9, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(395, 35, 10, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(396, 36, 11, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(397, 37, 12, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(398, 38, 13, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(399, 39, 14, 394, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(400, 40, 15, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.');



INSERT INTO comments (id, document_id, user_id, parent_comment_id, content) VALUES



(401, 41, 16, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(402, 42, 17, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(403, 43, 18, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(404, 44, 19, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(405, 45, 20, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(406, 46, 21, 401, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(407, 47, 22, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(408, 48, 23, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(409, 49, 24, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(410, 50, 25, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(411, 51, 26, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(412, 52, 27, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(413, 53, 28, 408, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(414, 54, 29, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(415, 55, 30, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(416, 56, 1, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(417, 57, 2, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(418, 58, 3, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(419, 59, 4, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(420, 60, 5, 415, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(421, 61, 6, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(422, 62, 7, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(423, 63, 8, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(424, 64, 9, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(425, 65, 10, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(426, 66, 11, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(427, 67, 12, 422, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(428, 68, 13, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(429, 69, 14, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(430, 70, 15, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(431, 71, 16, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(432, 72, 17, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(433, 73, 18, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(434, 74, 19, 429, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(435, 75, 20, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(436, 76, 21, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(437, 77, 22, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(438, 78, 23, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(439, 79, 24, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(440, 80, 25, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(441, 81, 26, 436, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(442, 82, 27, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(443, 83, 28, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(444, 84, 29, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(445, 85, 30, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(446, 86, 1, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(447, 87, 2, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(448, 88, 3, 443, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(449, 89, 4, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(450, 90, 5, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(451, 91, 6, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(452, 92, 7, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(453, 93, 8, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(454, 94, 9, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(455, 95, 10, 450, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(456, 96, 11, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(457, 97, 12, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(458, 98, 13, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(459, 99, 14, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(460, 100, 15, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(461, 101, 16, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(462, 102, 17, 457, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(463, 103, 18, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(464, 104, 19, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(465, 105, 20, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(466, 106, 21, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(467, 107, 22, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(468, 108, 23, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(469, 109, 24, 464, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(470, 110, 25, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(471, 111, 26, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(472, 112, 27, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(473, 113, 28, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(474, 114, 29, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(475, 115, 30, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(476, 116, 1, 471, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(477, 117, 2, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(478, 118, 3, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(479, 119, 4, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(480, 120, 5, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(481, 1, 6, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(482, 2, 7, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(483, 3, 8, 478, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(484, 4, 9, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(485, 5, 10, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(486, 6, 11, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(487, 7, 12, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(488, 8, 13, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(489, 9, 14, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(490, 10, 15, 485, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(491, 11, 16, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(492, 12, 17, NULL, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(493, 13, 18, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(494, 14, 19, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(495, 15, 20, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.'),



(496, 16, 21, NULL, '이 부분은 스포이트를 안정적으로 구성하면 좋을 것 같습니다.'),



(497, 17, 22, 492, '요약이 계속 반복되어서 더 줄이는 게 좋습니다.'),



(498, 18, 23, NULL, '이슈 관리를 시작할 때 이내를 함께 유지하면 후림에 좋고습니다.'),



(499, 19, 24, NULL, '사용자 흐름을 더 깊게 생각한 후 수정하면 좋을 것 같습니다.'),



(500, 20, 25, NULL, '요청의 순서를 조금만 더 미루면 가독성이 좋아집니다.');







INSERT INTO document_members (id, document_id, user_id, role) VALUES



(1, 1, 1, 'OWNER'),



(2, 1, 7, 'EDITOR'),



(3, 1, 12, 'VIEWER'),



(4, 2, 2, 'OWNER'),



(5, 2, 8, 'EDITOR'),



(6, 2, 13, 'VIEWER'),



(7, 3, 3, 'OWNER'),



(8, 3, 9, 'EDITOR'),



(9, 3, 14, 'VIEWER'),



(10, 4, 4, 'OWNER'),



(11, 4, 10, 'EDITOR'),



(12, 4, 15, 'VIEWER'),



(13, 5, 5, 'OWNER'),



(14, 5, 11, 'EDITOR'),



(15, 5, 16, 'VIEWER'),



(16, 6, 6, 'OWNER'),



(17, 6, 12, 'EDITOR'),



(18, 6, 17, 'VIEWER'),



(19, 7, 7, 'OWNER'),



(20, 7, 13, 'EDITOR'),



(21, 7, 18, 'VIEWER'),



(22, 8, 8, 'OWNER'),



(23, 8, 14, 'EDITOR'),



(24, 8, 19, 'VIEWER'),



(25, 9, 9, 'OWNER'),



(26, 9, 15, 'EDITOR'),



(27, 9, 20, 'VIEWER'),



(28, 10, 10, 'OWNER'),



(29, 10, 16, 'EDITOR'),



(30, 10, 21, 'VIEWER'),



(31, 11, 11, 'OWNER'),



(32, 11, 17, 'EDITOR'),



(33, 11, 22, 'VIEWER'),



(34, 12, 12, 'OWNER'),



(35, 12, 18, 'EDITOR'),



(36, 12, 23, 'VIEWER'),



(37, 13, 13, 'OWNER'),



(38, 13, 19, 'EDITOR'),



(39, 13, 24, 'VIEWER'),



(40, 14, 14, 'OWNER'),



(41, 14, 20, 'EDITOR'),



(42, 14, 25, 'VIEWER'),



(43, 15, 15, 'OWNER'),



(44, 15, 21, 'EDITOR'),



(45, 15, 26, 'VIEWER'),



(46, 16, 16, 'OWNER'),



(47, 16, 22, 'EDITOR'),



(48, 16, 27, 'VIEWER'),



(49, 17, 17, 'OWNER'),



(50, 17, 23, 'EDITOR'),



(51, 17, 28, 'VIEWER'),



(52, 18, 18, 'OWNER'),



(53, 18, 24, 'EDITOR'),



(54, 18, 29, 'VIEWER'),



(55, 19, 19, 'OWNER'),



(56, 19, 25, 'EDITOR'),



(57, 19, 30, 'VIEWER'),



(58, 20, 20, 'OWNER'),



(59, 20, 26, 'EDITOR'),



(60, 20, 1, 'VIEWER'),



(61, 21, 21, 'OWNER'),



(62, 21, 27, 'EDITOR'),



(63, 21, 2, 'VIEWER'),



(64, 22, 22, 'OWNER'),



(65, 22, 28, 'EDITOR'),



(66, 22, 3, 'VIEWER'),



(67, 23, 23, 'OWNER'),



(68, 23, 29, 'EDITOR'),



(69, 23, 4, 'VIEWER'),



(70, 24, 24, 'OWNER'),



(71, 24, 30, 'EDITOR'),



(72, 24, 5, 'VIEWER'),



(73, 25, 25, 'OWNER'),



(74, 25, 1, 'EDITOR'),



(75, 25, 6, 'VIEWER'),



(76, 26, 26, 'OWNER'),



(77, 26, 2, 'EDITOR'),



(78, 26, 7, 'VIEWER'),



(79, 27, 27, 'OWNER'),



(80, 27, 3, 'EDITOR'),



(81, 27, 8, 'VIEWER'),



(82, 28, 28, 'OWNER'),



(83, 28, 4, 'EDITOR'),



(84, 28, 9, 'VIEWER'),



(85, 29, 29, 'OWNER'),



(86, 29, 5, 'EDITOR'),



(87, 29, 10, 'VIEWER'),



(88, 30, 30, 'OWNER'),



(89, 30, 6, 'EDITOR'),



(90, 30, 11, 'VIEWER'),



(91, 31, 1, 'OWNER'),



(92, 31, 7, 'EDITOR'),



(93, 31, 12, 'VIEWER'),



(94, 32, 2, 'OWNER'),



(95, 32, 8, 'EDITOR'),



(96, 32, 13, 'VIEWER'),



(97, 33, 3, 'OWNER'),



(98, 33, 9, 'EDITOR'),



(99, 33, 14, 'VIEWER'),



(100, 34, 4, 'OWNER'),



(101, 34, 10, 'EDITOR'),



(102, 34, 15, 'VIEWER'),



(103, 35, 5, 'OWNER'),



(104, 35, 11, 'EDITOR'),



(105, 35, 16, 'VIEWER'),



(106, 36, 6, 'OWNER'),



(107, 36, 12, 'EDITOR'),



(108, 36, 17, 'VIEWER'),



(109, 37, 7, 'OWNER'),



(110, 37, 13, 'EDITOR'),



(111, 37, 18, 'VIEWER'),



(112, 38, 8, 'OWNER'),



(113, 38, 14, 'EDITOR'),



(114, 38, 19, 'VIEWER'),



(115, 39, 9, 'OWNER'),



(116, 39, 15, 'EDITOR'),



(117, 39, 20, 'VIEWER'),



(118, 40, 10, 'OWNER'),



(119, 40, 16, 'EDITOR'),



(120, 40, 21, 'VIEWER');



INSERT INTO document_members (id, document_id, user_id, role) VALUES



(121, 41, 11, 'OWNER'),



(122, 41, 17, 'EDITOR'),



(123, 41, 22, 'VIEWER'),



(124, 42, 12, 'OWNER'),



(125, 42, 18, 'EDITOR'),



(126, 42, 23, 'VIEWER'),



(127, 43, 13, 'OWNER'),



(128, 43, 19, 'EDITOR'),



(129, 43, 24, 'VIEWER'),



(130, 44, 14, 'OWNER'),



(131, 44, 20, 'EDITOR'),



(132, 44, 25, 'VIEWER'),



(133, 45, 15, 'OWNER'),



(134, 45, 21, 'EDITOR'),



(135, 45, 26, 'VIEWER'),



(136, 46, 16, 'OWNER'),



(137, 46, 22, 'EDITOR'),



(138, 46, 27, 'VIEWER'),



(139, 47, 17, 'OWNER'),



(140, 47, 23, 'EDITOR'),



(141, 47, 28, 'VIEWER'),



(142, 48, 18, 'OWNER'),



(143, 48, 24, 'EDITOR'),



(144, 48, 29, 'VIEWER'),



(145, 49, 19, 'OWNER'),



(146, 49, 25, 'EDITOR'),



(147, 49, 30, 'VIEWER'),



(148, 50, 20, 'OWNER'),



(149, 50, 26, 'EDITOR'),



(150, 50, 1, 'VIEWER'),



(151, 51, 21, 'OWNER'),



(152, 51, 27, 'EDITOR'),



(153, 51, 2, 'VIEWER'),



(154, 52, 22, 'OWNER'),



(155, 52, 28, 'EDITOR'),



(156, 52, 3, 'VIEWER'),



(157, 53, 23, 'OWNER'),



(158, 53, 29, 'EDITOR'),



(159, 53, 4, 'VIEWER'),



(160, 54, 24, 'OWNER'),



(161, 54, 30, 'EDITOR'),



(162, 54, 5, 'VIEWER'),



(163, 55, 25, 'OWNER'),



(164, 55, 1, 'EDITOR'),



(165, 55, 6, 'VIEWER'),



(166, 56, 26, 'OWNER'),



(167, 56, 2, 'EDITOR'),



(168, 56, 7, 'VIEWER'),



(169, 57, 27, 'OWNER'),



(170, 57, 3, 'EDITOR'),



(171, 57, 8, 'VIEWER'),



(172, 58, 28, 'OWNER'),



(173, 58, 4, 'EDITOR'),



(174, 58, 9, 'VIEWER'),



(175, 59, 29, 'OWNER'),



(176, 59, 5, 'EDITOR'),



(177, 59, 10, 'VIEWER'),



(178, 60, 30, 'OWNER'),



(179, 60, 6, 'EDITOR'),



(180, 60, 11, 'VIEWER'),



(181, 61, 1, 'OWNER'),



(182, 61, 7, 'EDITOR'),



(183, 61, 12, 'VIEWER'),



(184, 62, 2, 'OWNER'),



(185, 62, 8, 'EDITOR'),



(186, 62, 13, 'VIEWER'),



(187, 63, 3, 'OWNER'),



(188, 63, 9, 'EDITOR'),



(189, 63, 14, 'VIEWER'),



(190, 64, 4, 'OWNER'),



(191, 64, 10, 'EDITOR'),



(192, 64, 15, 'VIEWER'),



(193, 65, 5, 'OWNER'),



(194, 65, 11, 'EDITOR'),



(195, 65, 16, 'VIEWER'),



(196, 66, 6, 'OWNER'),



(197, 66, 12, 'EDITOR'),



(198, 66, 17, 'VIEWER'),



(199, 67, 7, 'OWNER'),



(200, 67, 13, 'EDITOR'),



(201, 67, 18, 'VIEWER'),



(202, 68, 8, 'OWNER'),



(203, 68, 14, 'EDITOR'),



(204, 68, 19, 'VIEWER'),



(205, 69, 9, 'OWNER'),



(206, 69, 15, 'EDITOR'),



(207, 69, 20, 'VIEWER'),



(208, 70, 10, 'OWNER'),



(209, 70, 16, 'EDITOR'),



(210, 70, 21, 'VIEWER'),



(211, 71, 11, 'OWNER'),



(212, 71, 17, 'EDITOR'),



(213, 71, 22, 'VIEWER'),



(214, 72, 12, 'OWNER'),



(215, 72, 18, 'EDITOR'),



(216, 72, 23, 'VIEWER'),



(217, 73, 13, 'OWNER'),



(218, 73, 19, 'EDITOR'),



(219, 73, 24, 'VIEWER'),



(220, 74, 14, 'OWNER'),



(221, 74, 20, 'EDITOR'),



(222, 74, 25, 'VIEWER'),



(223, 75, 15, 'OWNER'),



(224, 75, 21, 'EDITOR'),



(225, 75, 26, 'VIEWER'),



(226, 76, 16, 'OWNER'),



(227, 76, 22, 'EDITOR'),



(228, 76, 27, 'VIEWER'),



(229, 77, 17, 'OWNER'),



(230, 77, 23, 'EDITOR'),



(231, 77, 28, 'VIEWER'),



(232, 78, 18, 'OWNER'),



(233, 78, 24, 'EDITOR'),



(234, 78, 29, 'VIEWER'),



(235, 79, 19, 'OWNER'),



(236, 79, 25, 'EDITOR'),



(237, 79, 30, 'VIEWER'),



(238, 80, 20, 'OWNER'),



(239, 80, 26, 'EDITOR'),



(240, 80, 1, 'VIEWER');



INSERT INTO document_members (id, document_id, user_id, role) VALUES



(241, 81, 21, 'OWNER'),



(242, 81, 27, 'EDITOR'),



(243, 81, 2, 'VIEWER'),



(244, 82, 22, 'OWNER'),



(245, 82, 28, 'EDITOR'),



(246, 82, 3, 'VIEWER'),



(247, 83, 23, 'OWNER'),



(248, 83, 29, 'EDITOR'),



(249, 83, 4, 'VIEWER'),



(250, 84, 24, 'OWNER'),



(251, 84, 30, 'EDITOR'),



(252, 84, 5, 'VIEWER'),



(253, 85, 25, 'OWNER'),



(254, 85, 1, 'EDITOR'),



(255, 85, 6, 'VIEWER'),



(256, 86, 26, 'OWNER'),



(257, 86, 2, 'EDITOR'),



(258, 86, 7, 'VIEWER'),



(259, 87, 27, 'OWNER'),



(260, 87, 3, 'EDITOR'),



(261, 87, 8, 'VIEWER'),



(262, 88, 28, 'OWNER'),



(263, 88, 4, 'EDITOR'),



(264, 88, 9, 'VIEWER'),



(265, 89, 29, 'OWNER'),



(266, 89, 5, 'EDITOR'),



(267, 89, 10, 'VIEWER'),



(268, 90, 30, 'OWNER'),



(269, 90, 6, 'EDITOR'),



(270, 90, 11, 'VIEWER'),



(271, 91, 1, 'OWNER'),



(272, 91, 7, 'EDITOR'),



(273, 91, 12, 'VIEWER'),



(274, 92, 2, 'OWNER'),



(275, 92, 8, 'EDITOR'),



(276, 92, 13, 'VIEWER'),



(277, 93, 3, 'OWNER'),



(278, 93, 9, 'EDITOR'),



(279, 93, 14, 'VIEWER'),



(280, 94, 4, 'OWNER'),



(281, 94, 10, 'EDITOR'),



(282, 94, 15, 'VIEWER'),



(283, 95, 5, 'OWNER'),



(284, 95, 11, 'EDITOR'),



(285, 95, 16, 'VIEWER'),



(286, 96, 6, 'OWNER'),



(287, 96, 12, 'EDITOR'),



(288, 96, 17, 'VIEWER'),



(289, 97, 7, 'OWNER'),



(290, 97, 13, 'EDITOR'),



(291, 97, 18, 'VIEWER'),



(292, 98, 8, 'OWNER'),



(293, 98, 14, 'EDITOR'),



(294, 98, 19, 'VIEWER'),



(295, 99, 9, 'OWNER'),



(296, 99, 15, 'EDITOR'),



(297, 99, 20, 'VIEWER'),



(298, 100, 10, 'OWNER'),



(299, 100, 16, 'EDITOR'),



(300, 100, 21, 'VIEWER'),



(301, 101, 11, 'OWNER'),



(302, 101, 17, 'EDITOR'),



(303, 101, 22, 'VIEWER'),



(304, 102, 12, 'OWNER'),



(305, 102, 18, 'EDITOR'),



(306, 102, 23, 'VIEWER'),



(307, 103, 13, 'OWNER'),



(308, 103, 19, 'EDITOR'),



(309, 103, 24, 'VIEWER'),



(310, 104, 14, 'OWNER'),



(311, 104, 20, 'EDITOR'),



(312, 104, 25, 'VIEWER'),



(313, 105, 15, 'OWNER'),



(314, 105, 21, 'EDITOR'),



(315, 105, 26, 'VIEWER'),



(316, 106, 16, 'OWNER'),



(317, 106, 22, 'EDITOR'),



(318, 106, 27, 'VIEWER'),



(319, 107, 17, 'OWNER'),



(320, 107, 23, 'EDITOR'),



(321, 107, 28, 'VIEWER'),



(322, 108, 18, 'OWNER'),



(323, 108, 24, 'EDITOR'),



(324, 108, 29, 'VIEWER'),



(325, 109, 19, 'OWNER'),



(326, 109, 25, 'EDITOR'),



(327, 109, 30, 'VIEWER'),



(328, 110, 20, 'OWNER'),



(329, 110, 26, 'EDITOR'),



(330, 110, 1, 'VIEWER'),



(331, 111, 21, 'OWNER'),



(332, 111, 27, 'EDITOR'),



(333, 111, 2, 'VIEWER'),



(334, 112, 22, 'OWNER'),



(335, 112, 28, 'EDITOR'),



(336, 112, 3, 'VIEWER'),



(337, 113, 23, 'OWNER'),



(338, 113, 29, 'EDITOR'),



(339, 113, 4, 'VIEWER'),



(340, 114, 24, 'OWNER'),



(341, 114, 30, 'EDITOR'),



(342, 114, 5, 'VIEWER'),



(343, 115, 25, 'OWNER'),



(344, 115, 1, 'EDITOR'),



(345, 115, 6, 'VIEWER'),



(346, 116, 26, 'OWNER'),



(347, 116, 2, 'EDITOR'),



(348, 116, 7, 'VIEWER'),



(349, 117, 27, 'OWNER'),



(350, 117, 3, 'EDITOR'),



(351, 117, 8, 'VIEWER'),



(352, 118, 28, 'OWNER'),



(353, 118, 4, 'EDITOR'),



(354, 118, 9, 'VIEWER'),



(355, 119, 29, 'OWNER'),



(356, 119, 5, 'EDITOR'),



(357, 119, 10, 'VIEWER'),



(358, 120, 30, 'OWNER'),



(359, 120, 6, 'EDITOR'),



(360, 120, 11, 'VIEWER');







COMMIT;



