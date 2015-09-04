module Ruy
  module Conditions

    # Expects a successful evaluation of a sub-pair of conditions.
    #
    # Groups rules in slices of 2 conditions. Then evalutes each slice until one of them succeds.
    # If there's an even number of conditions, the last slice will have only one condition.
    #
    # Cond is handy for mocking if/else if/else constructs.
    class Cond < CompoundCondition
      def call(ctx)
        clauses = conditions.each_slice(2)

        clauses.any? do |rule_1, rule_2|
          result = rule_1.call(ctx)

          if rule_2
            result && rule_2.call(ctx)
          else
            result
          end
        end
      end
    end
  end
end
