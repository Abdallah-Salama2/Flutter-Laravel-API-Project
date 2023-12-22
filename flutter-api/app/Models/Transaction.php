<?php

namespace App\Models;

use App\Models\Scopes\AncientScope;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Carbon;

class Transaction extends Model
{
    use HasFactory;

    protected $fillable = [
        'category_id',
        'transaction_date',
        'amount',
        'description',
        'user_id',
    ];

    protected $casts = ['transaction_date' => 'datetime',];

    public function category()
    {
        return $this->belongsTo(Category::class);
    }

    public function setAmountAttribute($value)
    {
        $this->attributes['amount'] = $value * 100;
    }

    public function setTransactionDateAttrib($value)
    {
        $this->attributes['transaction_date'] = Carbon::createFromFormat('m/d/y', $value)->format('Y-m-d');
    }

    protected static function booted(): void
    {
        static::addGlobalScope(new AncientScope);
    }
}
