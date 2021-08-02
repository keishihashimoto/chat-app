# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## usersテーブル

| Column            | Type   | Options     |
| ----------------- | ------ | ----------- |
| name              | string | null: false |
| email             | string | null: false |
|encrypted_password | string | null: false |

### Association

- has_many :messages
- has_many :room_users
- has_many :rooms, through: :room_users


## roomsテーブル

| Column | Type   | Options     |
| ------ | ------ | ----------- |
| name   | string | null: false |

### Association
- has_many :messages
- has_many :users, through: :room_users
- has_many :room_users-

## messagesテーブル
 
| column  | Type      | Options                        |
| ------- | --------- | ------------------------------ |
| content | string    | null: false                    |
| image   | text      |                                |
| user    | reference | null: false, foreign_key: true |
| room    | reference | null: false, foreign_key: true |

### association

- belongs_to :user
- belongs_to :room


## room_usersテーブル

| Column | Type      | Options                        |
| ------ | --------- | ------------------------------ |
| user   | reference | null: false, foreign_key: true |
| room   | reference | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :room