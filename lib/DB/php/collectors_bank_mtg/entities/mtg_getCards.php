<?php

require_once (__DIR__."/../mtg_database.php");

class MTGCardsEntity
{
    private $connection;

    /**
     * MTGCardsEntity constructor.
     */
    public function __construct()
    {
        $constants = new Connection();
        $this->connection = $constants->getConnection();
    }

    /**
     * @return array
     */
    function getCards(): array
    {
        $cards = array();
        try {
            $request = "SELECT * 
            FROM cards 
            LEFT JOIN cardImages 
            ON cards.Nid = cardImages.ID 
            WHERE Nset = '".$_GET['setCode']."'
            ORDER BY CAST(cards.Nnumber AS INT);";
            $result = $this->connection->query($request);
            $cards = $result->fetchAll();

            return $cards;
        }
        catch(PDOException $e) {
            return $cards;
        }
    }
}
$run = new MTGCardsEntity();
echo json_encode($run->getCards());