local SumListS SumList Out1 Out2 in
    fun {SumList L}       // Declarative recursive
        case L
            of nil then 0
            [] '|'(1:H 2:T) then (H + {SumList T})
        end
    end

    fun {SumListS L}      // Stateful iterative
        local Helper C Out in
            newCell 0 C
            fun {Helper L C}
                case L
                    of nil then @C 
                    [] '|'(1:H 2:T) then
                    C := (@C+H)
                    {Helper T C}
                end
            end
            Out = {Helper L C}
            Out
        end
    end

    Out1 = {SumList [1 2 3 4]}
    Out2 = {SumListS [1 2 3 4]}
    skip Browse Out1
    skip Browse Out2
end