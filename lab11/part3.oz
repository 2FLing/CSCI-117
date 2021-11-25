local NewQueue S B1 A1 A2 B2  V1 V2 V3 Out Pu Po IsE Av in
    fun {NewQueue S}
        local Front Back Size Pu Po IsE Av in
            newCell 0 Size
            newCell nil Front
            newCell nil Back
            Pu = proc {$ N}
                if (@Size == 0) then
                    Front := (N|@Front)
                    Back := (N|@Back)
                    Size := (@Size + 1)
                else
                    if {LT @Size S} then
                        Back := (N|@Back)
                        Size := (@Size + 1)
                    else
                        (H|T) = @Front
                        (H1|T1) = @Back in
                        Front := (H1|T)
                        Back := (N|T1)
                    end
                end
            end
            Po = fun {$}
                if {GT @Size 1} then
                    (H|T) = @Front
                    (H1|T1) = @Back in
                    Front := (H1|T)
                    Back := T1
                    Size := (@Size - 1)
                    H
                else
                    if (@Size == 1) then
                        (H|T) = @Front in
                        Size := (@Size -1)
                        Front := nil
                        Back := nil
                        H
                    end
                end
            end
            IsE = fun {$}
                (@Size == 0)
            end
            Av = fun {$}
                (S-@Size)
            end
            ops(push:Pu pop:Po isEmpty:IsE avail:Av)
        end
    end
    S = {NewQueue 2}
    ops(push:Pu pop:Po isEmpty:IsE avail:Av) = S
    B1 = {IsE}
    A1 = {Av}
    {Pu 1}
    {Pu 2}
    A2 = {Av}
    {Pu 3}
    B2 = {IsE}
    V1 = {Po}
    V2 = {Po}
    V3 = {Po}
    Out = [V1 V2 V3 B1 B2 A1 A2]
    skip Browse Out   // Out : [ 2  3  Unbound  true()  false()  2  0 ]
end