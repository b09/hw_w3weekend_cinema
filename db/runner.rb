require('pg')

class SqlRunner

  def self.run(sql, values = [])
    begin
      db = PG.connect({dbname: 'codeclan_cinema', host: 'localhost'})
      db.prepare("query", sql)
      db_object = db.exec_prepared("query", values)
    ensure
      db.close() if db != nil
    end
    return db_object
  end

end
