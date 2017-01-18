require './purchase_log'
require './discounter'

class Totaler
    attr_reader :purchase_log

    def initialize(purchase_log)
        @purchase_log = purchase_log
    end

    def total 
        tally = purchase_log.tally
        transactors = [self, _discounter]
        transactors.reduce(0) {|memo, transactor| memo += transactor.transact(tally)}
    end

    def transact(tally)
        tally.reduce(0) {|memo, (item, count)| memo += item.price * count}
    end

    def _discounter
        Discounter.new
    end

end