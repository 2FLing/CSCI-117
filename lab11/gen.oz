local Generate GenF Out1 Out2 Out3 in
    fun {Generate}
        local C Helper in
            newCell -1 C
            fun {Helper}
                @C
            end
            C:=(@C+1)
            Helper
        end
    end
    GenF = {Generate}
    Out1={GenF} // returns 0
    Out2={GenF} // returns 1
    Out3={GenF} // returns 2
    skip Browse Out3
end