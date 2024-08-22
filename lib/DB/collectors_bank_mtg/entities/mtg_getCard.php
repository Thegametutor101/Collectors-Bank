<?php

require_once (__DIR__."/../mtg_database.php");

class MTGCardEntity
{
    private $connection;

    /**
     * MTGCardEntity constructor.
     */
    public function __construct()
    {
        $constants = new Connection();
        $this->connection = $constants->getConnection();
    }

    /**
     * @return array
     */
    function getCard(): array
    {
        $cards = array();
        try {
            $request = "SELECT * FROM cards Left JOIN cardImages on cards.Nid = cardImages.ID WHERE Nid = '".$_GET['cardCode']."';";
            $result = $this->connection->query($request);
            $cards = $result->fetchAll();

            return $cards;
        }
        catch(PDOException $e) {
            return $cards;
        }
    }
}
$run = new MTGCardEntity();
echo json_encode($run->getCard());