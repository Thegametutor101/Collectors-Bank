<?php

require_once (__DIR__."/../mtg_database.php");

class MTGSetsEntity
{
    private $connection;

    /**
     * MTGSetsEntity constructor.
     */
    public function __construct()
    {
        $constants = new Connection();
        $this->connection = $constants->getConnection();
    }

    /**
     * @return array
     */
    function getSets(): array
    {
        $sets = array();
        try {
            $request = "SELECT s.Nname, 
                s.Ncode, 
                CONCAT(CONCAT(SUBSTRING(s.Ndate, 4, 4), '/'), SUBSTRING(s.Ndate, 1, 2)) as NdateValue, 
                s.Nis_promo, 
                COUNT(DISTINCT c.Nid) as cardCount 
            FROM sets s 
            LEFT JOIN cards c 
            ON s.Ncode = c.Nset
            GROUP BY s.Ncode
            ORDER BY NdateValue DESC;";
            $result = $this->connection->query($request);
            $sets = $result->fetchAll();

            return $sets;
        }
        catch(PDOException $e) {
            return $sets;
        }
    }
}
$run = new MTGSetsEntity();
echo json_encode($run->getSets());