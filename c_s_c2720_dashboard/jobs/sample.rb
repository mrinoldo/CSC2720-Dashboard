current_valuation = 0
current_karma = 0

SCHEDULER.every '10s' do
  last_valuation = current_valuation
  current_valuation = rand(100)

  send_event('valuation', { current: current_valuation, last: last_valuation })
end