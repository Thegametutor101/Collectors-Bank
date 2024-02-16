<?php

class Connection
{
    private $connection;
    public function __construct()
    {
        try {
            $this->connection = new PDO(
                "mysql:host=localhost;dbname=id20653033_collectors_bank_mtg;port=3308,charset=utf8",
                "id20653033_collectors_bank_mtg_master",
                "lsdh[{6NnUGt[=v<");
            $this->connection->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        } catch (PDOException $e) {
            echo $e;
        }
    }

    /**
     * @return PDO
     */
    public function getConnection(): PDO
    {
        return $this->connection;
    }
}