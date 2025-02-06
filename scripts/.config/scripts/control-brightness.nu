#!/usr/bin/env nu

def main [action: string] {
    let op = match $action {
        "up" => '+1%',
        # Mind the order of the minus
        "down" => '1%-',
        _ => {error make { msg: 'The action needs to be up or down.' }}
    }

    brightnessctl set $op
    let val = (brightnessctl get | into float) * 100.0 / (brightnessctl max | into float) | into int
    let text = $"Brightness: ($val)"
    dunstify -t 600 -h string:x-canonical-private-synchronous:brightness $text -h $'int:value:($val)'
}
