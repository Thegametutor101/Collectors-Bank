<?php

require_once (__DIR__."/../mtg_database.php");

class MTGCardVariantsEntity
{
    private $connection;

    /**
     * MTGCardVariantsEntity constructor.
     */
    public function __construct()
    {
        $constants = new Connection();
        $this->connection = $constants->getConnection();
    }

    /**
     * @return array
     */
    function getVariants(): array
    {
        $cards = array();
        try {
            $request = "SELECT cards.Nid AS `cardID`,
            cards.Nname AS `cardName`,
            cards.Nnumber AS `cardNumber`,
            cards.Ntype AS `cardType`,
            cardImages.image AS `cardImage`,
            sets.Ncode AS `setCode`,
            sets.Nname AS `setName`,
            sets.Ndate AS `setDate`
            FROM cards 
            LEFT JOIN cardImages 
            ON cards.Nid = cardImages.ID  
            LEFT JOIN sets
            ON cards.Nset = sets.Ncode 
            WHERE UPPER(cards.Nname) = UPPER('".$_GET['cardName']."')
            ORDER BY CAST(sets.NDate AS DATE);";
            $result = $this->connection->query($request);
            $cards = $result->fetchAll();

            return $cards;
        }
        catch(PDOException $e) {
            return $cards;
        }
    }
}
$run = new MTGCardVariantsEntity();
echo json_encode($run->getVariants());