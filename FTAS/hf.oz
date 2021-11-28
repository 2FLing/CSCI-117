local Len L Out GenList in
    fun {GenList N L}
        if (N == 0) then
            L
        else
            {GenList (N-1) (N|L)}
        end
    end
    fun {Len L A}
        case L
            of nil then A
            [] '|'(1:H 2:T) then {Len T (A+1)}
        end
    end
    L = {GenList 1000 nil}
    Out = {Len L 0}
    skip Browse Out
end