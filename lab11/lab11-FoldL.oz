local FoldLS FoldL Out1 Out2 in
    fun {FoldL F Z L}            // Declarative recursive
        case L
            of nil then Z
            [] '|'(1:H 2:T) then {FoldL F {F Z H} T}
        end
    end

    fun {FoldLS F Z L}           // Stateful iterative
        local Helper C Out in
            newCell Z C
            fun{Helper F C L}
                case L
                    of nil then @C 
                    [] '|'(1:H 2:T) then
                    C := {F @C H}
                    {Helper F C T}
                end
            end
            Out = {Helper F C L}
            Out
        end
    end 

    Out1 = {FoldL fun {$ X Y} (X+Y) end 3 [1 2 3 4]}
    Out2 = {FoldLS fun {$ X Y} (X+Y) end 3 [1 2 3 4]}
    skip Browse Out1
    skip Browse Out2
end